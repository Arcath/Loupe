require File.expand_path("../../../config/environment.rb", __FILE__)

job "disk-build" do |args|
	`df > tmp/disk.txt`
	`df -h > tmp/disk-h.txt`
	file = File.new("tmp/disk.txt","r")
	while (line = file.gets)
		device = line.scan(/^(.*?) /).join
		if device != "none" and device != "Filesystem" then
			disk = Disk.find_or_create_by_name(device)
			blocks = line.scan(/^#{device} *(.*?) /).join
			used = line.scan(/^#{device} *#{blocks} *(.*?) /).join
			avaliable = line.scan(/#{used} *(.*?) /).join
			percent = line.scan(/^#{device} *#{blocks} *#{used} *#{avaliable} *(.*?) /).join
			disk.mountpoint = line.scan(/#{device} *#{blocks} *#{used} *#{avaliable} *#{percent} *(.*?)$/).join
			disk.used = used
			disk.avaliable = blocks
			disk.save
		end
	end
end

job "system-values" do |args|
	system = System.find_or_create_by_name("hostname")
	system.value = `hostname`.chomp
	system.save
	system = System.find_or_create_by_name("uptime")
	system.value = `uptime`.scan(/up (.*?),/).join
	system.save
	Stalker.enqueue("system-ram-build")
end

job "system-ram-build" do |args|
	file = File.new("/proc/meminfo", "r")
	while (line = file.gets)
		variable = line.scan(/^(.*?):/).join
		prevalue = line.chomp.scan(/ (.*?)$/).join
		value = prevalue.gsub(/ /,'').gsub(/kB/,'')
		system=System.find_or_create_by_name(variable)
		system.value = value
		system.save
	end
end
