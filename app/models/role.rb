##
# Defines all attributes for a Role in the system. An example type of role would be a Player, manager, referee, physio

class Role < ActiveRecord::Base
  extend Searchable
  validates :title, presence: true
  scope :filter_by_title, lambda { |keyword| where("lower(title) LIKE ?", "%#{keyword.downcase}%" ) }

  ##
  # Used when searching for Roles

  def self.id_params_identifier
    :role_ids
  end

end
