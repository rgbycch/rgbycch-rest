##
# Ensures a MatchDayPlayer is formatted correctly in API responses

class MatchDayPlayerSerializer < ActiveModel::Serializer

  attributes :id, :rating, :points, :fouls, :turnovers_for, :turnovers_against, :penalties_won, :penalties_conceded, :yellow_cards, :red_cards, :carries, :yards_carried, :forward_passes, :successful_lineout_throws, :unsuccessful_lineout_throws, :scrums_won, :scrums_lost, :successful_garryowens, :unsuccessful_garryowens

  has_one :player
  has_one :player_position

  ##
  # Defines the caching key for an official

  def cache_key
    [object, scope]
  end
end
