class CreateCommunes < ActiveRecord::Migration
  def change
    create_table :communes do |t|
      t.integer :province_id, :null => false
      t.string :name, :null => false
      t.timestamps null: false
    end
  end
end
