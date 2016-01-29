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

  def file_path
    Rails.root.join(ENV['JSON_CACHE_DIRECTORY'], ENV['JSON_CACHE_FULL_SCHEDULE'])
  end

  def get
    return fresh_schedule if context.fresh || !File.exist?(file_path)
    cached_schedule
  end

  def cached_schedule
    JSON.parse(File.read(file_path))
  end

  def fresh_schedule
    {
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
