##
# Defines all attributes for a team in the system.

class Team < ActiveRecord::Base
  validates :title, presence: true
  belongs_to :club
  has_and_belongs_to_many :players
end