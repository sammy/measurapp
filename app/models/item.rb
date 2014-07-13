class Item < ActiveRecord::Base
  
  include Sluggable
    
  belongs_to :user
  has_many :group_items
  has_many :groups, through: :group_items

  validates_presence_of :name
  
  before_create :generate_slug

  # def generate_slug
  #   slug = self.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/,'')
  #   if Item.where(:slug => slug).count > 0
  #     n = 1
  #     while Item.where(:slug => "#{slug}-#{n}").count > 0
  #       n += 1
  #     end
  #     self.slug = "#{slug}-#{n}"
  #   else
  #     self.slug = "#{slug}"
  #   end 
  # end

  # def to_param
  #   self.slug
  # end

end