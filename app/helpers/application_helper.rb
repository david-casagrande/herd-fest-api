module ApplicationHelper
  def set_time_for(band, venue)
    venue.set_times.select { |set_time| set_time.band == band }
  end
end
