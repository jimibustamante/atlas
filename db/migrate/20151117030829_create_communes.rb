class CreateCommunes < ActiveRecord::Migration
  def change
    create_table :communes do |t|

      t.timestamps null: false
    end
  end
end
