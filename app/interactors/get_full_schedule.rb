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
      venues: venues,
      set_times: set_times
    }
  end

  def bands
    BandSerializer.new(Band.all.includes(:set_times, :venues))
  end

  def venues
    VenueSerializer.new(Venue.all.includes(:set_times, :bands))
  end

  def set_times
    SetTimeSerializer.new(SetTime.all.includes(:band, :venue))
  end
end
