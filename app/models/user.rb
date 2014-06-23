class User < ActiveRecord::Base

  has_secure_password
  has_many :groups

  def full_name
    first_name + ' ' + last_name
  end
  
end