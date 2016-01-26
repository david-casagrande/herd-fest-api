class SetTimeSerializer
  include Serializer

  def serialize(model)
    {
      id: model.id,
      date: model.date,
      start_time: model.start_time,
      band: model.band.id,
      venue: model.venue.id
    }
  end
end
