class CreatePossibleWays < ActiveRecord::Migration
  def change
    create_table :possible_ways do |t|
      t.integer :point_id
      t.integer :target_point
      t.string :track_array

      t.timestamps null: false
    end
  end
end
