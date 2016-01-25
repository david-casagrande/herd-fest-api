module API
  class BandsController < APIController
    def index
      respond_with bands
    end

    private

    def bands
      @bands ||= Band.all
    end
  end
end
