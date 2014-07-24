class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.integer :value
      t.integer :item_id
      t.integer :group_id
      t.integer :measure_id
      t.timestamps
    end
  end
end
