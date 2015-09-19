##
# Defines all attributes for a team in the system.

class Team < ActiveRecord::Base
  validates :title, presence: true
end