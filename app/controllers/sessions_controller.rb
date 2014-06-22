class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by username: params[:username]

    if user && user.authenticate(params[:password])
      redirect_to home_path
      flash[:success] = 'You have logged in!'
    end
  end

end