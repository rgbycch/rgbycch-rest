##
# Defines all attributes for a score type in the system. An example type of score is a 'try', 'penalty' or 'drop goal'

class ScoreType < ActiveRecord::Base
  validates :title, presence: true
  validates :points, numericality: { greater_than_or_equal_to: 0 },
            presence: true
end
