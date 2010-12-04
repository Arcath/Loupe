class Float
	def to_mb
		(self/1024).round(2)
	end
	
	def to_gb
		(self.to_mb/1024).round(2)
	end
	
	def to_tb
		(self.to_gb/1024).round(2)
	end
	
	def to_cscale
		if self < 716800.0 then
			return self.to_mb
		elsif self < 734003200 then
			return self.to_gb
		else
			return self.to_tb
		end
	end
	
	def cscale_unit
		if self < 716800.0 then
			return "MB"
		elsif self < 734003200 then
			return "GB"
		else
			return "TB"
		end	
	end
end
