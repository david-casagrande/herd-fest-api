require 'test_helper'

describe SendNotification do
  it 'opens connection to houston connection, creates notification for all devices and writes, closes connection' do
    device = Fabricate(:device)
    Fabricate(:device, device_token: nil)

    message = 'sup'

    connection_mock = MiniTest::Mock.new
    connection_mock.expect(:open, nil)
    connection_mock.expect(:write, nil, [message])
    connection_mock.expect(:close, nil)

    connection = lambda do |uri, certificate, passphrase|
      assert_equal Houston::APPLE_DEVELOPMENT_GATEWAY_URI, uri
      assert_equal ENV['APN_CERTIFICATE_DATA'], certificate
      assert_equal ENV['APN_CERTIFICATE_PASSPHRASE'], passphrase

      connection_mock
    end

    notification_mock = MiniTest::Mock.new
    notification_mock.expect(:alert=, nil, [message])
    notification_mock.expect(:message, message)

    notification = lambda do |opts|
      assert_equal opts[:device], device.device_token

      notification_mock
    end

    Houston::Connection.stub(:new, connection) do
      Houston::Notification.stub(:new, notification) do
        SendNotification.call(message: message)
      end
    end

    assert connection_mock.verify
    assert notification_mock.verify
  end

  it 'opens connection to houston connection, creates notification for given device and writes, closes connection' do
    device = Fabricate(:device)
    Fabricate(:device)
    Fabricate(:device)

    message = 'sup'

    connection_mock = MiniTest::Mock.new
    connection_mock.expect(:open, nil)
    connection_mock.expect(:write, nil, [message])
    connection_mock.expect(:close, nil)

    connection = lambda do |uri, certificate, passphrase|
      assert_equal Houston::APPLE_DEVELOPMENT_GATEWAY_URI, uri
      assert_equal ENV['APN_CERTIFICATE_DATA'], certificate
      assert_equal ENV['APN_CERTIFICATE_PASSPHRASE'], passphrase

      connection_mock
    end

    notification_mock = MiniTest::Mock.new
    notification_mock.expect(:alert=, nil, [message])
    notification_mock.expect(:message, message)

    notification = lambda do |opts|
      assert_equal opts[:device], device.device_token

      notification_mock
    end

    Houston::Connection.stub(:new, connection) do
      Houston::Notification.stub(:new, notification) do
        SendNotification.call(message: message, devices: [device])
      end
    end

    assert connection_mock.verify
    assert notification_mock.verify
  end
end
