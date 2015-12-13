##
# Ensures an EventType is formatted correctly in API responses

class EventTypeSerializer < ActiveModel::Serializer

  attributes :id, :title, :url

  ##
  # Defines the caching key for an EventType

  def cache_key
    [object, scope]
  end
end
