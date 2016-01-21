class CreateSetTime < ActiveRecord::Migration
  def change
    create_table :set_times do |t|
      t.uuid :band_id
      t.date :date
      t.time :start_time
      t.uuid :venue_id
      t.timestamps
    end

    add_index :set_times, :band_id
    add_index :set_times, :venue_id
  end
end
