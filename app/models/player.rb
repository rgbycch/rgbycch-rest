##
# Defines all attributes for a player in the system.

class Player < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_and_belongs_to_many :teams
  has_many :preferred_positions, dependent: :destroy
  has_many :positions, through: :preferred_positions
  scope :filter_by_name, lambda { |keyword|
    where("lower(first_name) LIKE ? OR lower(last_name) LIKE ? OR lower(nick_name) LIKE ?", "%#{keyword.downcase}%", "%#{keyword.downcase}%", "%#{keyword.downcase}%" )
  }

  ##
  # Search method used by the index endpoint of the Players controller.

  def self.search(params = {})
    players = params[:player_ids].present? ? Player.find(params[:player_ids]) : Player.all
    players = players.filter_by_name(params[:keyword]) if params[:keyword]
    players
  end
end
