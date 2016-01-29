module Serializer
  def initialize(model)
    @model = model
  end

  # inherited class must define to_h with passed model argument
  # TODO: better api for this?
  def serialize(model)
  end

  def to_h
    if @model.respond_to?(:to_a) # TODO: better way to check if its a collection?
      @model.map { |model| serialize(model) }
    else
      serialize(@model)
    end
  end

  alias to_hash to_h
  delegate :to_json, to: :to_h
end
