class ApplicationController < ActionController::Base
	protect_from_forgery
	before_filter :check_on_god
	
	private
	
	def check_on_god
		god_status = System.find_by_name("God status")
		if god_status.value == "Check"
			unless `god status` =~ /Loupe:/ 
				flash[:warning] = "God was not running"
				`god -c #{RAILS_ROOT}/config/loupe.god`
				god_status.value = "Running"
				god_status.save
				#Put the new workers to work straight away
				Stalker.enqueue("disk-build")
				Stalker.enqueue("system-values")
				Stalker.enqueue("system-ram-build")
			else
				god_status.value = "Running"
				god_status.save
			end
		end
	end
end
