##
# Defines all attributes for a player in the system.

class Player < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_and_belongs_to_many :teams
  has_many :preferred_positions, dependent: :destroy
  has_many :positions, through: :preferred_positions
end
