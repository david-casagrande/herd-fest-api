class Device < ActiveRecord::Base
  validates :device_id, presence: true
  validates :device_token, presence: true
end
