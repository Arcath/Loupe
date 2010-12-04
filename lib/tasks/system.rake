namespace :system do
	desc "Get the system values e.g. hostname and distro"
	task :values => :environment do
		system = System.find_or_create_by_name("hostname")
		system.value = `hostname`.chomp
		system.save
		system = System.find_or_create_by_name("uptime")
		system.value = `uptime`.scan(/up (.*?),/).join
		system.save
	end
end
