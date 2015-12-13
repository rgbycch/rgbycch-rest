##
# Ensures a ScoreType is formatted correctly in API responses

class ScoreTypeSerializer < ActiveModel::Serializer

  attributes :id, :title, :url, :points

  ##
  # Defines the caching key for a ScoreType

  def cache_key
    [object, scope]
  end
end
