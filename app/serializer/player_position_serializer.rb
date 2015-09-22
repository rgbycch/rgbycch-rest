##
# Ensures a player position is formatted correctly in API responses

class PlayerPositionSerializer < ActiveModel::Serializer

  attributes :id, :title, :url, :position_number

  ##
  # Defines the caching key for a player position

  def cache_key
    [object, scope]
  end
end
