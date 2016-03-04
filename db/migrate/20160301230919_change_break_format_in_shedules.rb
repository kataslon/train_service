class ChangeBreakFormatInShedules < ActiveRecord::Migration
  def change
    change_column :shedules, :breack, :integer
  end
end
