##
# Defines all attributes for an role in the system. An example type of role would be a player, manager, referee, physio

class Role < ActiveRecord::Base
  extend Searchable
  validates :title, presence: true
  scope :filter_by_title, lambda { |keyword| where("lower(title) LIKE ?", "%#{keyword.downcase}%" ) }

  def self.id_params_identifier
    :role_ids
  end

end
