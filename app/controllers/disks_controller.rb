class DisksController < ApplicationController
	def index
		@disks = Disk.all
	end
	
	def rebuild
		@disks = Disk.all
		Stalker.enqueue("disk-build")
	end
	
	def show
		@disk = Disk.find_by_id(params[:id])
	end
	
	def raw
		@file = File.new("tmp/disk-h.txt","r")
	end
end
