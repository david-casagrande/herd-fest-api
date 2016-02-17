class AddDayIdToSetTimes < ActiveRecord::Migration
  def change
    add_column :set_times, :day_id, :uuid
  end
end
