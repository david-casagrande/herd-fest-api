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
      @bands ||= Band.all.includes(:set_times)
    end
  end
end
