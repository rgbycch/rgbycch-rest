##
# Defines all attributes for a club in the system.

class Club < ActiveRecord::Base
  validates :name, presence: true
end
