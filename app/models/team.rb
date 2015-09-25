##
# Defines all attributes for a team in the system.

class Team < ActiveRecord::Base
  extend Searchable
  validates :title, presence: true
  belongs_to :club
  has_and_belongs_to_many :players
  scope :filter_by_title, lambda { |keyword| where("lower(title) LIKE ?", "%#{keyword.downcase}%" ) }

  def self.id_params_identifier
    :team_ids
  end

end