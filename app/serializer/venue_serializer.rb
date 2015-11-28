##
# Ensures a venue is formatted correctly in API responses

class VenueSerializer < ActiveModel::Serializer

  attributes :id, :title, :url, :latitude, :longitude, :capacity

  ##
  # Defines the caching key for a venue

  def cache_key
    [object, scope]
  end
end
