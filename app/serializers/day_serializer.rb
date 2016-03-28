class DaySerializer
  include Serializer

  def serialize(model)
    {
      id: model.id,
      name: model.name,
      date: model.date,
      bands: model.bands.map(&:id),
      venues: model.venues.map(&:id),
      set_times: model.set_times.map(&:id)
    }
  end
end
