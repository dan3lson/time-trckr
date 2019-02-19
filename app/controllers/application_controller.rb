class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

  private

  def invalid_record(_error)
    flash.now[:danger] = 'Name is required'
    respond_to do |format|
      format.js { render template: 'logs/invalid_record.js.erb' }
    end
  end
end
