##
# Defines all attributes for a Venue in the system.

class Venue < ActiveRecord::Base
  extend Searchable
  validates :title, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  scope :filter_by_title, lambda { |keyword| where("lower(title) LIKE ?", "%#{keyword.downcase}%" ) }

  ##
  # Used when searching for Venues

  def self.id_params_identifier
    :venue_ids
  end

end
