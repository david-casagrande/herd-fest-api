class BandSerializer
  include Serializer

  def serialize(model)
    {
      id: model.id,
      description: model.description,
      image_url: model.image_url,
      name: model.name,
      set_times: model.set_times.map(&:id),
      venues: model.venues.map(&:id),
      facebook_url: model.facebook_url,
      twitter_url: model.twitter_url
    }
  end
end
