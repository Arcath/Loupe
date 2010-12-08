module HomeHelper
	def total_memory
		System.find_by_name("MemTotal").value.to_f + System.find_by_name("SwapTotal").value.to_f
	end
	
	def ram_total
		System.find_by_name("MemTotal").value.to_f
	end
	
	def swap_total
		System.find_by_name("SwapTotal").value.to_f
	end
	
	def ram_used
		ram_total - System.find_by_name("MemFree").value.to_f
	end
	
	def swap_used
		swap_total - System.find_by_name("SwapFree").value.to_f
	end
end
