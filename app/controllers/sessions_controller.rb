class SessionsController < Clearance::SessionsController
  def destroy
    flash[:success] = 'Successfully signed out'
    super
  end
end
