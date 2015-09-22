##
# Defines all attributes a player's preferred position

class PreferredPosition < ActiveRecord::Base
  validates :preference, numericality: { greater_than_or_equal_to: 0 },
            presence: true
  belongs_to :player
  belongs_to :player_position
end
