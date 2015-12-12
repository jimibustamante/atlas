class AddColumnsToMiningWastes < ActiveRecord::Migration
  def change
    add_column :mining_wastes, :mining_waste_type, :string
    add_column :mining_wastes, :partial_volume, :string
    add_column :mining_wastes, :total_volume, :string
    add_column :mining_wastes, :partial_ton, :string
    add_column :mining_wastes, :total_ton, :string
    add_column :mining_wastes, :resolution, :string
    add_column :mining_wastes, :resolution_date, :date
    add_column :mining_wastes, :resolution_number, :string
    add_column :mining_wastes, :resolution_closure_date, :date
    add_column :mining_wastes, :resolution_closure_number, :string
  end
end
