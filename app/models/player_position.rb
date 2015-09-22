##
# Defines all attributes for a player position in the system. An example type of player position is a 'scrum half', 'full back' or 'prop forward'

class PlayerPosition < Role
  validates :title, presence: true
  validates :position_number, numericality: { greater_than_or_equal_to: 0 },
            presence: true
  has_many :preferred_positions, dependent: :destroy
  has_many :players, through: :preferred_positions
  scope :filter_by_title, lambda { |keyword|
    where("lower(title) LIKE ?", "%#{keyword.downcase}%" )
  }

  ##
  # Search method used by the index endpoint of the PlayerPositions controller.

  def self.search(params = {})
    player_positions = params[:player_position_ids].present? ? PlayerPosition.find(params[:player_position_ids]) : PlayerPosition.all
    player_positions = player_positions.filter_by_title(params[:keyword]) if params[:keyword]
    player_positions
  end
end
