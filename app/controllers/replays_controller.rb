class ReplaysController < ApplicationController
  before_action :require_login

  def new
    @log        = replayed_log
    @started_at = Time.current
  end

  def create
    @log            = current_user.logs.create!(log_params)
    flash[:success] = 'Log successfully created'
    redirect_to logs_path
  end

  private

  def replayed_log
    current_user.logs.find(params[:log_id])
  end

  def log_params
    log_params              = {}
    log_params[:name]       = replayed_log.name
    log_params[:started_at] = params[:started_at]
    log_params[:stopped_at] = Time.current
    log_params[:tag_ids]    = replayed_log.tags.pluck(:id)
    log_params
  end

  def raw_params
    params.permit(:log_id)
  end
end
