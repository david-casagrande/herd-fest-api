class Device < ActiveRecord::Base
  crypt_keeper :device_token, encryptor: :postgres_pgp, key: ENV['CRYPT_KEEPER_KEY'], salt: ENV['CRYPT_KEEPER_SALT'], :encoding => 'UTF-8'

  validates :device_id, presence: true
  validates :device_token, presence: true
end
