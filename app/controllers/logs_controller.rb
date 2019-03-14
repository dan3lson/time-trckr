class LogsController < ApplicationController
  def index
    @logs = Log.today.latest
  end

  def new
    @log = Log.new
    @tags = Tag.all
  end

  def create
    @log = Log.new(log_params)
    raise ActiveRecord::RecordInvalid unless @time.positive?

    @log.save!
    flash[:success] = 'Log successfully created'
    redirect_to logs_path
  end

  def destroy
    @log = Log.find(params[:id])
    @log.destroy!
    flash[:success] = 'Log successfully removed'
    redirect_to logs_path
  end

  private

  def log_params
    @time = params[:log][:minutes].to_i
    {
      name: params[:log][:name],
      started_at: @time.minutes.ago,
      stopped_at: Time.current,
      tag_ids: params[:log][:tag_ids]
    }
  end

  def raw_params
    params.permit(:name, :minutes, tag_ids: [])
  end
end
