class MeasureItem < ActiveRecord::Base

  belongs_to    :measure
  belongs_to    :item
  
end