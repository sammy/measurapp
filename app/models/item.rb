class Item < ActiveRecord::Base
  
  belongs_to :user
  has_many :group_items
  has_many :groups, through: :group_items

  validates_presence_of :name
  
end