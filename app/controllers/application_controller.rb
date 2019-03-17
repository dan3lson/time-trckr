class ApplicationController < ActionController::Base
  include Clearance::Controller

  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

  def authenticate_admin_user!
    unless current_user == admin_user
      flash[:danger] = 'Access denied'
      redirect_to root_path
    end
  end

  def current_admin_user
    admin_user
  end

  private

  def admin_user
    User.find_by(email: 'danelson.rosa@gmail.com')
  end

  def invalid_record(_error)
    respond_to do |format|
      format.js { render template: 'shared/invalid_record.js.erb' }
    end
  end
end
