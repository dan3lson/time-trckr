module ApplicationHelper
	# == Today
	#
	# Today's date in the format
	# of Day, Month Weekday #.
	#
	# @return String
	#
  def today
    format_date(Time.current)
  end

	# == Format date
	#
	# Returns a string in the format
	# of Day, Month Weekday #.
	#
	# @return String
	#
  def format_date(date)
    date.strftime('%A, %B %d')
  end
end
