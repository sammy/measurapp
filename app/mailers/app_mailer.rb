class AppMailer < ActionMailer::Base

  def new_registration(user)
    @user = user
    mail  from:     'info@measureapp.com',
          to:       user.email,
          subject:  'Welcome to MeasureApp' 
  end

end