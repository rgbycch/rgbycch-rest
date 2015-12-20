##
# Ensures a match state is formatted correctly in API responses

class MatchStateSerializer < ActiveModel::Serializer

  attributes :id, :title

  ##
  # Defines the caching key for a match state

  def cache_key
    [object, scope]
  end
end
