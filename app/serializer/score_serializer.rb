##
# Ensures a score is formatted correctly in API responses

class ScoreSerializer < ActiveModel::Serializer

  attributes :id, :home_score, :away_score

  ##
  # Defines the caching key for a score

  def cache_key
    [object, scope]
  end
end
