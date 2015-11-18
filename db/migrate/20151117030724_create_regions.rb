class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name, :null => false
      t.string :region_number, :null => false
      t.timestamps null: false
    end
  end
end
