class Disk < ActiveRecord::Base
	def percent
		((used/avaliable)*100).round(2)
	end
end
