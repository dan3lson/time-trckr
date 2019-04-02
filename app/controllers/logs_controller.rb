class LogsController < ApplicationController
  before_action :require_login
  before_action :validate_positive_minutes, only: %i[create update]

  def index
    @logs = current_user.logs.today.latest
  end

  def new
    @log = Log.new
    @tags = current_user.tags
  end

  def create
    current_user.logs.create!(log_params)
    flash[:success] = 'Log successfully created'
    redirect_to logs_path
  end

  def edit
    @log = Log.find(params[:id])
    @tags = current_user.tags
  end

  def update
    log = current_user.logs.find(params[:id])
    log.update!(log_params)
    flash[:success] = 'Log successfully updated'
    redirect_to logs_path
  end

  def destroy
    current_user.logs.find(params[:id]).destroy!
    flash[:success] = 'Log successfully removed'
    redirect_back(fallback_location: logs_path)
  end

  private

  # == Validate Positive Minutes
  #
  # Ensure minutes is greater
  # than zero.
  #
  # @return Boolean
  #
  def validate_positive_minutes
    raise ActiveRecord::RecordInvalid unless minutes.positive?
  end

  def log_params
    {
      name: params[:log][:name],
      started_at: minutes.minutes.ago,
      stopped_at: Time.current,
      tag_ids: params[:log][:tag_ids]
    }
  end

  def minutes
    params[:log][:minutes].to_i
  end

  def raw_params
    params.permit(:name, :minutes, tag_ids: [])
  end
end
