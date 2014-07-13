class Group < ActiveRecord::Base

  include Sluggable
    
  belongs_to :user
  has_many :group_items
  has_many :items, through: :group_items
  validates_presence_of :name

  before_create :generate_slug

  # def generate_slug
  #   slug = self.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/,'')
  #   if Group.where(:slug => slug).count > 0
  #     n = 1
  #     while Group.where(:slug => "#{slug}-#{n}").count > 0
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