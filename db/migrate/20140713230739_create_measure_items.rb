class CreateMeasureItems < ActiveRecord::Migration
  def change
    create_table :measure_items do |t|
      t.integer :measure_id
      t.integer :item_id
      t.timestamps
    end
  end
end
