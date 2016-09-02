class DeviceTokenToString < ActiveRecord::Migration
  def change
    change_column(:devices, :device_token, :text)
  end
end
