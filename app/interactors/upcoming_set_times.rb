class UpcomingSetTimes
  include Interactor

  def call
    context.results = set_times
    send_notifications
  end

  private

  def send_notifications
    set_times.each do |set_time|
      SendNotification.call(devices: devices(set_time), message: message(set_time))
    end
  end

  def set_times
    @set_times ||= SetTime.joins(:day).where(start_time: start_time_query).where(days: { date: date_query }).order(:start_time)
  end

  def start_time_query
    1.second.from_now..10.minutes.from_now
  end

  def date_query
    Time.current.hour < 7 ? Date.yesterday : Time.zone.today
  end

  def devices(set_time)
    Device.where('schedule ? :set_time', set_time: set_time.id)
  end

  def message(set_time)
    "#{set_time.band.name} #{message_start_time(set_time)} @ #{set_time.venue.name}."
  end

  def message_start_time(set_time)
    set_time_min = set_time.start_time.min
    now_min = Time.current.min
    on_in = set_time_min - now_min

    on_in = (set_time_min + 60) - now_min if on_in < 1

    "is on in #{on_in} minutes"
  end
end
