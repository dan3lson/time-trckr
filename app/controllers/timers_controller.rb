class TimersController < ApplicationController
  before_action :require_login

  def new
    @log = Log.new(started_at: Time.current)
    @tags = current_user.tags
  end

  def create
    current_user.logs.create!(logs_params)
    flash[:success] = 'Log successfully created'
    redirect_to logs_path
  end

  private

  def logs_params
    params.require(:log).permit(:name, :started_at, :stopped_at, tag_ids: [])
  end
end
