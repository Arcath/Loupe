namespace :services do
	desc "Build the list of services"
	task :list => :environment do
		`service --status-all > tmp/service.txt`
		file = File.new("tmp/service.txt","r")
		while (line = file.gets)
			service = Service.find_or_create_by_name(line.scan(/\] *(.*?)$/).join)
			if line =~ /\+/ then
				service.status = "running"
			else
				service.status = "offline"
			end
			service.save
		end
	end
end
