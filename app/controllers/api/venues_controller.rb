module API
  class VenuesController < APIController
    def index
      respond_with venues
    end

    private

    def venues
      @venues ||= Venue.all
    end
  end
end
