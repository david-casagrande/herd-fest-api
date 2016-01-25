class BandSerializer < BaseSerializer
  def serialize(model)
    {
      id: model.id,
      description: model.description,
      name: model.name,
      set_times: model.set_times.map(&:id),
      venues: model.venues.map(&:id)
    }
  end
end
