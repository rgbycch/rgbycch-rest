##
# Defines all attributes for an match state in the system. A MatchState could be Kick Off, Full Time or Half Time.

class MatchState < ActiveRecord::Base
  extend Searchable
  validates :title, presence: true
  scope :filter_by_title, lambda { |keyword| where("lower(title) LIKE ?", "%#{keyword.downcase}%" ) }

  ##
  # Used when searching for match states

  def self.id_params_identifier
    :match_state_ids
  end

end
