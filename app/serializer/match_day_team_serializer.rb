##
# Ensures a MatchDayTeam is formatted correctly in API responses

class MatchDayTeamSerializer < ActiveModel::Serializer

  attributes :id, :title, :url

  has_many :match_day_players

  ##
  # Defines the caching key for a MatchDayTeam

  def cache_key
    [object, scope]
  end
end
