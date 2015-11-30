##
# Ensures a match-day team is formatted correctly in API responses

class MatchDayTeamSerializer < ActiveModel::Serializer

  attributes :id, :title, :url

  has_many :match_day_players

  ##
  # Defines the caching key for a club

  def cache_key
    [object, scope]
  end
end
