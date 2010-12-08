class HomeController < ApplicationController
	def index
		Stalker.enqueue("system-ram-build")
	end
end
