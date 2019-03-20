class ReplaysController < ApplicationController
  before_action :require_login

  def new
    @log = replayed_log
    @started_at = raw_params[:started_at]
  end

  def create
    @log = current_user.logs.create!(log_params)
    flash[:success] = 'Log successfully created'
    redirect_to logs_path
  end

  private

  def replayed_log
    current_user.logs.find(params[:log_id])
  end

  def log_params
    {
      name: replayed_log.name,
      started_at: params[:started_at],
      stopped_at: Time.current,
      tag_ids: replayed_log.tags.pluck(:id)
    }
  end

  def raw_params
    params.permit(:log_id, :started_at)
  end
end
