##
# Ensures a player state is formatted correctly in API responses

class PlayerStateSerializer < ActiveModel::Serializer

  attributes :id, :title, :url

  ##
  # Defines the caching key for a player state

  def cache_key
    [object, scope]
  end
end
