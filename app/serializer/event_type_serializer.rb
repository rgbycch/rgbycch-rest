##
# Ensures an event type is formatted correctly in API responses

class EventTypeSerializer < ActiveModel::Serializer

  attributes :id, :title, :url

  ##
  # Defines the caching key for an event type

  def cache_key
    [object, scope]
  end
end
