class ConversionsController < ApplicationController
  before_action :require_login

  def show
    @log = Log.find(params[:id])
    @unit = params[:unit] == 'hours' ? 'minutes' : 'hours'
    @letter = @unit[0]
    respond_to do |format|
      format.js
    end
  end
end
