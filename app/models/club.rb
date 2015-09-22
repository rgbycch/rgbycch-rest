##
# Defines all attributes for a club in the system.

class Club < ActiveRecord::Base
  validates :name, presence: true
  has_many :teams
  scope :filter_by_name, lambda { |keyword|
    where("lower(name) LIKE ?", "%#{keyword.downcase}%" )
  }
end
