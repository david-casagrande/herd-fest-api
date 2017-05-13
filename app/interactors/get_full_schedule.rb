class GetFullSchedule
  include Interactor

  def call
    context.fresh ||= false

    begin
      context.result = get
    rescue StandardError => e
      context.fail!(error: e)
    end
  end

  private

  def get
    return fresh_schedule if context.fresh || !cached_schedule
    cached_schedule.data
  end

  def cached_schedule
    @cached_schedule ||= CacheStore.latest
  end

  def fresh_schedule
    @fresh_schedule ||= {
      bands: bands,
      days: days,
      venues: venues,
      set_times: set_times
    }
  end

  def bands
    BandSerializer.new(Band.where(active: true).includes(:set_times, :venues))
  end

  def days
    DaySerializer.new(Day.where(active: true).includes(:set_times, :bands, :venues))
  end

  def venues
    VenueSerializer.new(Venue.where(active: true).includes(:set_times, :bands))
  end

  def set_times
    st =
      SetTime
      .joins(:band, :day, :venue)
      .where(bands: { active: true }, days: { active: true }, venues: { active: true })
      .includes(:band, :venue)

    SetTimeSerializer.new(st)
  end
end
