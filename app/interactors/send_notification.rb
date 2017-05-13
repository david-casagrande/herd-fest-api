require 'houston'

class SendNotification
  include Interactor

  def call
    connection.open

    devices.each do |device|
      notification = create_notification(device.device_token)
      connection.write(notification.message)
    end

    connection.close
  end

  private

  def devices
    context.devices ||= Device.where.not(device_token: nil)
  end

  def create_notification(device)
    notification = Houston::Notification.new(device: device)
    notification.alert = context.message
    notification
  end

  def connection
    @connection ||= Houston::Connection.new(uri, certificate, passphrase)
  end

  def certificate
    ENV['APN_CERTIFICATE_DATA']
  end

  def passphrase
    ENV['APN_CERTIFICATE_PASSPHRASE']
  end

  def uri
    ENV['RAILS_ENV'] == 'production' ? Houston::APPLE_PRODUCTION_GATEWAY_URI : Houston::APPLE_DEVELOPMENT_GATEWAY_URI
  end
end
