class Measure < ActiveRecord::Base

  belongs_to :user
  validates_presence_of :name, :min_value, :max_value
  validate :correct_range, on: [:create, :update]

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
end