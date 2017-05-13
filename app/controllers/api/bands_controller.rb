module API
  class BandsController < APIController
    def index
      respond_with serialized_bands
    end

    private

    def serialized_bands
      @serialized_bands ||= BandSerializer.new(bands)
    end

    def bands
      @bands ||= Band.where(active: true).includes(:set_times, :venues)
    end
  end
end
