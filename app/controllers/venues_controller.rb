class VenuesController < ApplicationController
  def index
  end

  private

  def venues
    @venues ||= Venue.all
  end
  helper_method :venues
end
