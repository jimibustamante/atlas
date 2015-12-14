class ChangeDataTypeToUtm < ActiveRecord::Migration
  def change
    change_column :mining_wastes, :utm_north, :string
    change_column :mining_wastes, :utm_east, :string
  end
end
