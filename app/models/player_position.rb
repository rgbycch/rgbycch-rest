##
# Defines all attributes for a PlayerPosition in the system. An example type of PlayerPosition is a 'scrum half', 'full back' or 'prop forward'

class PlayerPosition < Role
  extend Searchable
  validates :title, presence: true
  validates :position_number, numericality: { greater_than_or_equal_to: 0 },
            presence: true
  has_many :preferred_positions, dependent: :destroy
  has_many :players, through: :preferred_positions
  scope :filter_by_title, lambda { |keyword| where("lower(title) LIKE ?", "%#{keyword.downcase}%" ) }

  ##
  # Used when searching for PlayerPositions

  def self.id_params_identifier
    :player_position_ids
  end

end
