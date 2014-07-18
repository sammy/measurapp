class AddGroupIdToMeasureItems < ActiveRecord::Migration
  def change
    add_column :measure_items, :group_id, :integer
  end
end
