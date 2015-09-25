##
# Defines all attributes for an event type in the system. An example type of event is a 'knock on' or 'substitution'

class EventType < ActiveRecord::Base
  extend Searchable

  validates :title, presence: true
  scope :filter_by_title, lambda { |keyword| where("lower(title) LIKE ?", "%#{keyword.downcase}%" ) }

  def self.id_params_identifier
    :event_type_ids
  end

end
