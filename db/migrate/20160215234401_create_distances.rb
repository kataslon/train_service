class CreateDistances < ActiveRecord::Migration
  def change
    create_table :distances do |t|
      t.integer :point_id
      t.integer :neighbor_id
      t.integer :distance

      t.timestamps null: false
    end
  end
end
