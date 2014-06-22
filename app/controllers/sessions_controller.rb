class SessionsController < ApplicationController

  def new
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

end