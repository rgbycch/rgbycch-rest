##
# Defines all attributes for a team in the system.

class Team < ActiveRecord::Base
  extend Searchable
  validates :title, presence: true
  belongs_to :club
  has_many :team_players
  has_many :players, through: :team_players
  scope :filter_by_title, lambda { |keyword| where("lower(title) LIKE ?", "%#{keyword.downcase}%" ) }

  def self.id_params_identifier
    :team_ids
  end

end