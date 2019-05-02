module LogsHelper
	# == Editing Log?
	#
	# See if user is on the
	# logs#edit page.
	#
	# @return Boolean
	#
	def editing_log?
		params[:controller] == 'logs' && params[:action] == 'edit'
	end

	# == Filled? (log, tag)
	#
	# See if a log has the
	# given tag, which will be
	# pre-filled in on the
	# logs#edit page.
	#
	# @return Boolean
	#
  def filled?(log, tag)
    editing_log? && log.tag?(tag)
  end
end
