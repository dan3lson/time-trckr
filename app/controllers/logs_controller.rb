class LogsController < ApplicationController
  before_action :require_login

  def index
    @logs = current_user.logs.today.latest
  end

  def new
    @log = Log.new
    @tags = Tag.all
  end

  def create
    raise ActiveRecord::RecordInvalid unless time.positive?

    current_user.logs.create!(log_params)
    flash[:success] = 'Log successfully created'
    redirect_to logs_path
  end

  def destroy
    current_user.logs.find(params[:id]).destroy!
    flash[:success] = 'Log successfully removed'
    redirect_to logs_path
  end

  private

  def log_params
    {
      name: params[:log][:name],
      started_at: time.minutes.ago,
      stopped_at: Time.current,
      tag_ids: params[:log][:tag_ids]
    }
  end

  def time
    params[:log][:minutes].to_i
  end

  def raw_params
    params.permit(:name, :minutes, tag_ids: [])
  end
end
