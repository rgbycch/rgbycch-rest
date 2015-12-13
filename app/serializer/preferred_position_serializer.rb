##
# Ensures a PreferredPosition is formatted correctly in API responses

class PreferredPositionSerializer < ActiveModel::Serializer

  attributes :id, :preference

  has_one :player
  has_one :player_position

  ##
  # Defines the caching key for a PreferredPosition

  def cache_key
    [object, scope]
  end
end
