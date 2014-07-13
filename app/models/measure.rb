class Measure < ActiveRecord::Base

  include Sluggable

  belongs_to  :user
  has_many    :items
  
  validates_presence_of :name, :min_value, :max_value
  validate :correct_range, on: [:create, :update]

  before_create :generate_slug

  def type
    range == (0..1) ? 'Boolean' : 'Scale'
  end

  def range
    min_value..max_value
  end

  def correct_range
    if min_value.present? && max_value.present?
      errors.add(:min_value, "can't be larger than maximum value!") if self.min_value > self.max_value
    end
  end

  def groups
  end

  def groups=(groups)
    # groups.each do |g|
    #   group = Group.find(g)
    #   group.assign_measure if group
    # end
  end

end