class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user
  before_action :current_user
  
  def current_user
    @current_user ||= User.find(session[:user]) if session[:user]
  end

  def logged_in?
    !!current_user
  end

  def check_session
    unless logged_in?
      redirect_to root_path 
      flash[:alert] = 'You must first sign in to access this page.'
    end
  end

end
