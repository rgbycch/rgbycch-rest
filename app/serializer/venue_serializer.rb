##
# Ensures a Venue is formatted correctly in API responses

class VenueSerializer < ActiveModel::Serializer

  attributes :id, :title, :url, :latitude, :longitude, :capacity

  ##
  # Defines the caching key for a Venue

  def cache_key
    [object, scope]
  end
end
