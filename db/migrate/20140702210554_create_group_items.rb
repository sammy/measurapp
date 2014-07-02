class CreateGroupItems < ActiveRecord::Migration
  def change
    create_table :group_items do |t|
      t.integer :group_id
      t.integer :item_id
      t.timestamps
    end
  end
end
