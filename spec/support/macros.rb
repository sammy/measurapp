def set_current_user(user=nil)
  new_user ||= Fabricate(:user)
  session[:user] = new_user.id
end

def clear_current_user
  session[:user] = nil
end

