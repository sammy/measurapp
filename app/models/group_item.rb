class GroupItem < ActiveRecord::Base
  belongs_to :group
  belongs_to :item
end