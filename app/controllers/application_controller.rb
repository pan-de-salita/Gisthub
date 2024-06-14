class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :logged_in_user

  def authenticate_user!
    redirect_to root_path unless current_user
  end

  def current_user
    @current_user ||=
      begin
        return nil unless session[:user_id]

        User.find(session[:user_id])
      end
  end

  def logged_in_user
    return unless current_user && request.path == '/'

    redirect_to overview_path(current_user.alias)
    return if current_user

    flash[:danger] = 'Please log in.'
    redirect_to login_path
  end
end
