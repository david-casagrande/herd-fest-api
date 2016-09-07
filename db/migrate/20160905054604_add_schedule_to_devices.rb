class AddScheduleToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :schedule, :jsonb, null: false, default: '[]'
  end
end
