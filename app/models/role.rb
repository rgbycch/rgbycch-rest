##
# Defines all attributes for an role in the system. An example type of role would be a player, manager, referee, physio

class Role < ActiveRecord::Base
  validates :title, presence: true
  scope :filter_by_title, lambda { |keyword|
    where("lower(title) LIKE ?", "%#{keyword.downcase}%" )
  }

  ##
  # Search method used by the index endpoint of the Roles controller.

  def self.search(params = {})
    roles = params[:role_ids].present? ? Role.find(params[:role_ids]) : Role.all
    roles = roles.filter_by_title(params[:keyword]) if params[:keyword]
    roles
  end
end
