##
# Defines all attributes for an event type in the system. An example type of event is a 'knock on' or 'substitution'

class EventType < ActiveRecord::Base
  validates :title, presence: true
  scope :filter_by_title, lambda { |keyword|
    where("lower(title) LIKE ?", "%#{keyword.downcase}%" )
  }

  ##
  # Search method used by the index endpoint of the EventTypes controller.

  def self.search(params = {})
    event_types = params[:event_type_ids].present? ? EventType.find(params[:event_type_ids]) : EventType.all
    event_types = event_types.filter_by_title(params[:keyword]) if params[:keyword]
    event_types
  end

end
