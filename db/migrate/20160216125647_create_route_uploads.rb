class CreateRouteUploads < ActiveRecord::Migration
  def change
    create_table :route_uploads do |t|
      t.integer :route_id
      t.string :route_file

      t.timestamps null: false
    end
  end
end
