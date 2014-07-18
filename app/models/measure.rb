class Measure < ActiveRecord::Base

  include Sluggable

  belongs_to  :user
  has_many    :measure_items
  has_many    :items, through: :measure_items

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
    groups_by_id = measure_items.map(&:group_id).uniq
    group_objects = []
    groups_by_id.each do |id|
      group = Group.find(id)
      group_objects << group
    end
    group_objects
  end

  def groups=(groups)
    groups.shift
    groups.each do |g|
      group = Group.find(g) 
      group.items.each do |item|
        MeasureItem.create(measure_id: id, item_id: item.id, group_id: group.id)
      end
    end
  end
end