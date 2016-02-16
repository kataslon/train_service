class CreateShedules < ActiveRecord::Migration
  def change
    create_table :shedules do |t|
      t.integer :point_id
      t.integer :route_id
      t.time :breack
      t.boolean :first_point, default: false
      t.boolean :last_point, default: false

      t.timestamps null: false
    end
  end
end
