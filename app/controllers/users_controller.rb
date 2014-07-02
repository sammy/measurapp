class UsersController < ApplicationController

  def new
    if @current_user
      redirect_to home_path 
      flash[:info] = 'You are already registered and signed in!'
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    @user.save
    flash[:success] = 'You have registered successfully. Check your mailbox!'
    AppMailer.new_registration(@user).deliver
    redirect_to login_path
  end

  private

  def user_params
    params.require(:user).permit!
  end
end

