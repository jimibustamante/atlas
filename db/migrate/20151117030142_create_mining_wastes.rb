class CreateMiningWastes < ActiveRecord::Migration
  def change
    create_table :mining_wastes do |t|
      t.string :status, :null => false
      t.decimal :utm_north, {:precision => 10, :scale => 6}
      t.decimal :height, {:precision => 10, :scale => 6}
      t.decimal :utm_east, {:precision => 10, :scale => 6}
      t.timestamps null: false
    end
  end
end
