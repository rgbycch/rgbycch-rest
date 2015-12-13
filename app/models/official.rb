##
# Defines all attributes for an official in the system.

class Official < ActiveRecord::Base
  extend Searchable
  validates :title, presence: true
  scope :filter_by_title, lambda { |keyword| where("lower(title) LIKE ?", "%#{keyword.downcase}%" ) }

  ##
  # Used when searching for officials

  def self.id_params_identifier
    :official_ids
  end

end
