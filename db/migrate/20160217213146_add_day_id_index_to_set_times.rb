class AddDayIdIndexToSetTimes < ActiveRecord::Migration
  def change
    add_index :set_times, :day_id
  end
end
