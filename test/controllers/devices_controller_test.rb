require 'test_helper'

describe API::DevicesController do
  describe '#create' do
    it 'creates a new device if one does not exist with given device_id' do
      id = SecureRandom.uuid
      post :create, device_id: id, device_token: 'token'

      assert_response :success
      assert_equal 1, Device.count
    end

    it 'does not create a new device if one exists with given device_id' do
      id = SecureRandom.uuid
      device = Fabricate(:device, device_id: id)

      post :create, device_id: id, device_token: device.device_token

      assert_response :success
      assert_equal 1, Device.count
    end

    it 'does not create a new device if one exists with given device_id and device_token' do
      id = SecureRandom.uuid
      Fabricate(:device, device_id: id)

      post :create, device_id: id, device_token: 'new-token'

      assert_response :success
      assert_equal 'new-token', Device.find_by(device_id: id).device_token
    end

    it 'does not fail if device_token is sent with nil' do
      id = SecureRandom.uuid
      Fabricate(:device, device_id: id)

      post :create, device_id: id, device_token: nil

      assert_response :success
      assert_equal nil, Device.find_by(device_id: id).device_token
    end

    it 'fails if device_id is sent with nil' do
      id = SecureRandom.uuid
      device = Fabricate(:device, device_id: id)

      post :create, device_id: nil, device_token: device.device_token

      assert_response 422
    end
  end

  describe '#schedule' do
    it 'creates a new device if one does not exist with given device_id' do
      id = SecureRandom.uuid
      post :schedule, device_id: id, schedule: []

      assert_response :success
      assert_equal 1, Device.count
    end

    it 'updated device schedule' do
      device = Fabricate(:device, schedule: [])
      post :schedule, device_id: device.id, schedule: ['id']

      assert_response :success
      assert_equal ['id'], Device.find_by(device_id: device.id).schedule
    end
  end
end
