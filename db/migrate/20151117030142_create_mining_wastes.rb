class CreateMiningWastes < ActiveRecord::Migration
  def change
    create_table :mining_wastes do |t|
      t.integer :sernageomin_id, :null => false, :unique => true
      t.string :status, :null => false
      t.string :name
      t.decimal :height, {:precision => 10, :scale => 6}
      t.decimal :utm_north, {:precision => 10, :scale => 6}
      t.decimal :utm_east, {:precision => 10, :scale => 6}
      t.decimal :lon, {:precision => 10, :scale => 6}
      t.decimal :lat, {:precision => 10, :scale => 6}
      t.integer :labor_id, :null => false
      t.integer :region_id, :null => false
      t.timestamps null: false
    end
    add_index :mining_wastes, :sernageomin_id 
  end
end
