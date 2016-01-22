module ApplicationHelper
  def set_time_for(band, venue)
    venue.set_times.select { |set_time| set_time.band == band }
  end

  def default_date(date)
    date.strftime('%D')
  end

  def default_time(time)
    time.strftime('%l:%M %p')
  end
end
