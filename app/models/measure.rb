class Measure < ActiveRecord::Base

  include Sluggable

  belongs_to :user
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

  # def generate_slug
  #   slug = self.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/,'')
  #   if Measure.where(:slug => slug).count > 0
  #     n = 1
  #     while Measure.where(:slug => "#{slug}-#{n}").count > 0
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