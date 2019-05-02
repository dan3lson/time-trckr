class HistoriesController < ApplicationController
  before_action :require_login

  def index
    @num_weeks_ago = params[:num_weeks_ago].to_i || 0
    @logs = current_user.weekly_logs(@num_weeks_ago)
    respond_to do |format|
      format.html
      format.js
    end
  end
end
