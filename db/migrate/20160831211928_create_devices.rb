class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices, id: :uuid do |t|
      t.uuid :device_id
      t.string :device_token
      t.timestamps
    end

    add_index :devices, :device_id
  end
end
