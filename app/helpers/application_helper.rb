module ApplicationHelper
	def today
		Time.current.strftime('%A, %B %d')
	end
end
