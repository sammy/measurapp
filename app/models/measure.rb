class Measure < ActiveRecord::Base

  belongs_to :user
  validates_presence_of :name, :min_value, :max_value  

  def type
    range == (0..1) ? 'Boolean' : 'Scale'
  end

  def range
    min_value..max_value
  end
  
end