class CreateMeasures < ActiveRecord::Migration
  def change
    create_table :measures do |t|
      t.string    :name
      t.text      :description
      t.integer   :min_value
      t.integer   :max_value
      t.integer   :user_id
      t.timestamps
    end
  end
end
