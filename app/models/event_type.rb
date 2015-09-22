##
# Defines all attributes for an event type in the system. An example type of event is a 'knock on' or 'substitution'

class EventType < ActiveRecord::Base
  validates :title, presence: true
  scope :filter_by_title, lambda { |keyword|
    where("lower(title) LIKE ?", "%#{keyword.downcase}%" )
  }
end
