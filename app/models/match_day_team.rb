##
# Defines all attributes for a MatchDayTeam in the system.

class MatchDayTeam < ActiveRecord::Base
  extend Searchable
  validates :title, presence: true
  belongs_to :team, dependent: :destroy
  has_many :match_day_players, dependent: :destroy
  scope :filter_by_title, lambda { |keyword| where("lower(title) LIKE ?", "%#{keyword.downcase}%" ) }

  ##
  # Used when searching for MatchDayTeams

  def self.id_params_identifier
    :match_day_team_ids
  end
end
