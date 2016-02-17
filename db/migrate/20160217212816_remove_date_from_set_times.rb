class RemoveDateFromSetTimes < ActiveRecord::Migration
  def change
    remove_column :set_times, :date, :date
  end
end
