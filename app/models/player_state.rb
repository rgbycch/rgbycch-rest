##
# Defines all attributes for a PlayerState in the system. A PlayerState could be Active, Suspended, Retired.

class PlayerState < ActiveRecord::Base
  extend Searchable
  validates :title, presence: true
  scope :filter_by_title, lambda { |keyword| where("lower(title) LIKE ?", "%#{keyword.downcase}%" ) }

  ##
  # Used when searching for PlayerStates

  def self.id_params_identifier
    :player_state_ids
  end

end
