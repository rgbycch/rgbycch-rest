##
# Ensures a score type is formatted correctly in API responses

class ScoreTypeSerializer < ActiveModel::Serializer

  attributes :id, :title, :url, :points

  ##
  # Defines the caching key for a score type

  def cache_key
    [object, scope]
  end
end
