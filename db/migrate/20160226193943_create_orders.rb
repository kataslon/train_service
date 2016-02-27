class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :start_point
      t.integer :goal_point
      t.date    :date
      t.string  :nodes_array
      t.string  :track_array

      t.timestamps null: false
    end
  end
end
