##
# Defines all attributes for a Club in the system.

class Club < ActiveRecord::Base
  extend Searchable
  validates :title, presence: true
  has_many :teams, dependent: :destroy
  scope :filter_by_title, lambda { |keyword| where("lower(title) LIKE ?", "%#{keyword.downcase}%" ) }

  ##
  # Used when searching for Clubs

  def self.id_params_identifier
    :club_ids
  end

end
