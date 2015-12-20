##
# Defines all attributes for an Official in the system.

class Official < ActiveRecord::Base
  extend Searchable
  validates :title, presence: true
  scope :filter_by_title, lambda { |keyword| where("lower(title) LIKE ?", "%#{keyword.downcase}%" ) }

  ##
  # Used when searching for Officials

  def self.id_params_identifier
    :official_ids
  end

end
