class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :name
      t.integer :speed
      t.integer :places_count
      t.datetime :daparture
      t.decimal :tariff, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
