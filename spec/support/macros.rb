def set_current_user(user=nil)
  user ||= Fabricate(:user)
  session[:user] = user.id
end

def clear_current_user
  session[:user] = nil
end

