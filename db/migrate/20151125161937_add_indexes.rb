class AddIndexes < ActiveRecord::Migration
  def change
    add_index :mining_wastes, :labor_id
    add_index :mining_wastes, :region_id
    add_index :labors, :commune_id
    add_index :labors, :owner_id
  end
end
