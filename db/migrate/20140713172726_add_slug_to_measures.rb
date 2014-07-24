class AddSlugToMeasures < ActiveRecord::Migration
  def change
    add_column :measures, :slug, :string
  end
end
