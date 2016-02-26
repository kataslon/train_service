class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.integer :point_id
      t.string :naighbors_array

      t.timestamps null: false
    end
  end
end
