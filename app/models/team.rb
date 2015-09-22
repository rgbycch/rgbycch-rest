##
# Defines all attributes for a team in the system.

class Team < ActiveRecord::Base
  validates :title, presence: true
  belongs_to :club
  has_and_belongs_to_many :players
  scope :filter_by_title, lambda { |keyword|
    where("lower(title) LIKE ?", "%#{keyword.downcase}%" )
  }

  ##
  # Search method used by the index endpoint of the Teams controller.

  def self.search(params = {})
    teams = params[:team_ids].present? ? Team.find(params[:team_ids]) : Team.all
    teams = teams.filter_by_title(params[:keyword]) if params[:keyword]
    teams
  end
end