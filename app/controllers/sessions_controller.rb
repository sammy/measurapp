class SessionsController < ApplicationController

  def new
    redirect_to home_path if logged_in? 
  end

  def create
    user = User.find_by username: params[:username]

    if user && user.authenticate(params[:password])
      redirect_to home_path
      flash[:success] = 'You have logged in!'
      session[:user] = user.id
    else
      flash[:alert] = 'Login Failed. Wrong username or password.'
      render :new
    end
  end

  def destroy
    flash[:alert] = 'You are not authorized to view this page. You have to be logged in' if !logged_in?
    flash[:alert] = "Hi #{current_user.first_name}, you have successfully logged out!" if logged_in?
    session[:user] = nil
    redirect_to login_path
  end

end