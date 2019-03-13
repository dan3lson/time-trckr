class LogsController < ApplicationController
  def index
    @logs = Log.today.latest
  end

  def new
    @log = Log.new
  end

  def create
    @minutes = params[:log][:minutes].to_i
    @started_at = @minutes.minutes.ago
    @stopped_at = Time.current
    @log = Log.new(
      name: params[:log][:name],
      started_at: @started_at,
      stopped_at: @stopped_at
    )
    raise ActiveRecord::RecordInvalid unless @minutes.positive?

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

  def logs_params
    params.require(:log).permit(:name, tags: [])
  end
end
