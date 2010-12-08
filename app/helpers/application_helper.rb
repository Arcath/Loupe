module ApplicationHelper
	def jsit(*args)
		content_for(:jsit, javascript_include_tag(*args))
	end
end
