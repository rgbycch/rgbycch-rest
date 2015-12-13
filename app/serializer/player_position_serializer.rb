##
# Ensures a PlayerPosition is formatted correctly in API responses

class PlayerPositionSerializer < ActiveModel::Serializer

  attributes :id, :title, :url, :position_number

  ##
  # Defines the caching key for a PlayerPosition

  def cache_key
    [object, scope]
  end
end
