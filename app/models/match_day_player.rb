##
# Defines all attributes for a match-day player in the system. A match-day player is different from a regular player in that it records a player's state in a match.

class MatchDayPlayer < ActiveRecord::Base
  belongs_to :player
  belongs_to :player_position
  validates :rating, numericality: { greater_than_or_equal_to: 0 }
  validates :points, numericality: { greater_than_or_equal_to: 0 }
  validates :fouls, numericality: { greater_than_or_equal_to: 0 }
  validates :turnovers_for, numericality: { greater_than_or_equal_to: 0 }
  validates :turnovers_against, numericality: { greater_than_or_equal_to: 0 }
  validates :penalties_won, numericality: { greater_than_or_equal_to: 0 }
  validates :penalties_conceded, numericality: { greater_than_or_equal_to: 0 }
  validates :yellow_cards, numericality: { greater_than_or_equal_to: 0 }
  validates :red_cards, numericality: { greater_than_or_equal_to: 0 }
  validates :carries, numericality: { greater_than_or_equal_to: 0 }
  validates :yards_carried, numericality: { greater_than_or_equal_to: 0 }
  validates :forward_passes, numericality: { greater_than_or_equal_to: 0 }
  validates :successful_lineout_throws, numericality: { greater_than_or_equal_to: 0 }
  validates :unsuccessful_lineout_throws, numericality: { greater_than_or_equal_to: 0 }
  validates :scrums_won, numericality: { greater_than_or_equal_to: 0 }
  validates :scrums_lost, numericality: { greater_than_or_equal_to: 0 }
  validates :successful_garryowens, numericality: { greater_than_or_equal_to: 0 }
  validates :unsuccessful_garryowens, numericality: { greater_than_or_equal_to: 0 }
end
