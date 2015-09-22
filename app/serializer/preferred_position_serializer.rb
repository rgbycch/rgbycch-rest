##
# Ensures a preferred position is formatted correctly in API responses

class PreferredPositionSerializer < ActiveModel::Serializer

  attributes :id, :preference

  has_one :player
  has_one :player_position

  ##
  # Defines the caching key for a preferred position

  def cache_key
    [object, scope]
  end
end
