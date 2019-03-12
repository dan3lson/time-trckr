class TimersController < ApplicationController
  def new
    @log = Log.new
  end

  def create
    @log = Log.new(logs_params)
    @log.save!
    flash[:success] = 'Log successfully created'
    redirect_to logs_path
  end

  private

  def logs_params
    params.require(:log).permit(:name, :started_at, :stopped_at, tags: [])
  end
end