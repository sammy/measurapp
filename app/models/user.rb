class User < ActiveRecord::Base

  has_secure_password
  validates_presence_of :username, :email, :first_name, :last_name
  validates_uniqueness_of :username, :email
  has_many :groups
  has_many :items
  has_many :measures

  def full_name
    first_name + ' ' + last_name
  end
  
end