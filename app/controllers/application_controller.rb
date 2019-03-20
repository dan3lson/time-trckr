class ApplicationController < ActionController::Base
  include Clearance::Controller

  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

  # == Authenticate Admin User!
  #
  # Ensure the current_user is
  # authorized to access ActiveAdmin.
  # Method used in ActiveAdmin
  # initalizer.
  #
  def authenticate_admin_user!
    unless current_user == admin_user
      flash[:danger] = 'Access denied'
      redirect_to root_path
    end
  end


  # == Current Admin User
  #
  # Set the admin user to the
  # current_admin_user, which is to
  # authoriz access to ActiveAdmin.
  # Method used in ActiveAdmin
  # initalizer.
  #
  def current_admin_user
    admin_user
  end

  private

  def admin_user
    User.find_by(email: 'danelson.rosa@gmail.com')
  end

  # == Invalid Record
  #
  # Handle any form submission errors
  # with JS.
  #
  def invalid_record(_error)
    respond_to do |format|
      format.js { render template: 'shared/invalid_record.js.erb' }
    end
  end
end
