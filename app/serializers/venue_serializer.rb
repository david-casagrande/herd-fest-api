class VenueSerializer
  include Serializer

  def serialize(model)
    {
      id: model.id,
      name: model.name,
      street_address: model.street_address,
      set_times: model.set_times.active.map(&:id),
      bands: model.bands.map(&:id)
    }
  end
end
