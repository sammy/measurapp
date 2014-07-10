class Measure < ActiveRecord::Base

  belongs_to :user
  validates_presence_of :name, :min_value, :max_value  
  
end