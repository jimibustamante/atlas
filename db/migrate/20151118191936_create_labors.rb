class CreateLabors < ActiveRecord::Migration
  def change
    create_table :labors do |t|
      t.string :name, :null => false
      t.integer :owner_id, :null => false
      t.timestamps null: false
    end
  end
end
