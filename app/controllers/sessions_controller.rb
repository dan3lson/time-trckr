class SessionsController < Clearance::SessionsController
  def destroy
    flash[:success] = 'Successfully signed out; stay productive, my friends.'
    super
  end
end
