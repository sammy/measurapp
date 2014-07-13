class Item < ActiveRecord::Base
  
  include Sluggable

  belongs_to :user
  has_many :group_items
  has_many :groups, through: :group_items

  validates_presence_of :name
  
  before_create :generate_slug

end