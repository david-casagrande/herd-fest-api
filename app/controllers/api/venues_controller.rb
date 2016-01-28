module API
  class VenuesController < APIController
    def index
      respond_with serialized_venues
    end

    private

    def serialized_venues
      @serialized_bands ||= VenueSerializer.new(venues)
    end

    def venues
      @venues ||= Venue.all.includes(:set_times, :bands)
    end
  end
end
