class SetTimeSerializer
  include Serializer

  def serialize(model)
    {
      id: model.id,
      start_time: model.start_time,
      band: model.band.id,
      day: model.day.id,
      venue: model.venue.id
    }
  end
end
