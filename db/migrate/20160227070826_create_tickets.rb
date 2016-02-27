class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :order_id
      t.integer :route_id
      t.integer :start_point
      t.integer :finish_point
      t.date    :route_round_date

      t.timestamps null: false
    end
  end
end
