##
# Defines all attributes for an role in the system. An example type of role would be a player, manager, referee, physio

class Role < ActiveRecord::Base
  validates :title, presence: true
end
