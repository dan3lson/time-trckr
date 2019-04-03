class ConversionsController < ApplicationController
  before_action :require_login

  def show
    @log = Log.find(params[:id])
    @unit = Log.convert(params[:unit])
    @letter = @unit[0]
    respond_to do |format|
      format.js
    end
  end
end
