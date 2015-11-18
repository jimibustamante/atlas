class CreateProvinces < ActiveRecord::Migration
  def change
    create_table :provinces do |t|
      t.string :name, :null => false
      t.integer :region_id, :null => false
      t.timestamps null: false
    end
  end
end
