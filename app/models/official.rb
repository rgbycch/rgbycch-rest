##
# Defines all attributes for an official in the system.

class Official < ActiveRecord::Base
  extend Searchable
  validates :title, presence: true
  has_many :roles

  def self.id_params_identifier
    :official_ids
  end
end
