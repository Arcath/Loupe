namespace :disk do
	desc "Populates disk table"
	task :build => :environment do
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
end
