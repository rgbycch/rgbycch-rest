##
# Defines all attributes for a match venue in the system.

class Venue < ActiveRecord::Base
  extend Searchable
  validates :title, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  scope :filter_by_title, lambda { |keyword| where("lower(title) LIKE ?", "%#{keyword.downcase}%" ) }

  def self.id_params_identifier
    :venue_ids
  end

end
