##
# Defines all attributes for a player in the system.

class Player < ActiveRecord::Base
  extend Searchable
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_many :team_players
  has_many :teams, through: :team_players
  has_many :preferred_positions, dependent: :destroy
  has_many :positions, through: :preferred_positions
  scope :filter_by_title, lambda { |keyword| where("lower(first_name) LIKE ? OR lower(last_name) LIKE ? OR lower(nick_name) LIKE ?", "%#{keyword.downcase}%", "%#{keyword.downcase}%", "%#{keyword.downcase}%" ) }

  def self.id_params_identifier
    :player_ids
  end
end
