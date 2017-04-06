class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_driver, :logged_in?
  def current_driver
    @current_driver ||= Driver.find(session[:driver_id]) if session[:driver_id]
  end
  def logged_in?
    !!current_driver
  end
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform this acction"
      redirect_to root_path
    end
  end
end
