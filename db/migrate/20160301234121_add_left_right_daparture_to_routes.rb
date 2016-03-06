class AddLeftRightDapartureToRoutes < ActiveRecord::Migration
  def change
    rename_column :routes, :daparture, :left_daparture
    change_column :routes, :left_daparture, :time
    add_column :routes, :right_daparture, :time
  end
end
