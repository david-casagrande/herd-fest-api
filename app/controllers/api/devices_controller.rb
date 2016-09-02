module API
  class DevicesController < APIController
    skip_before_action :verify_authenticity_token

    def create
      if device.device_token != create_params['device_token']
        device.update(device_token: create_params['device_token'])
      end

      respond_with device, location: nil
    end

    private

    def device
      @device ||= Device.find_or_create_by(device_id: create_params['device_id'])
    end

    def create_params
      params.permit(:device_id, :device_token)
    end
  end
end
