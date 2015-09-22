##
# Defines all attributes for a club in the system.

class Club < ActiveRecord::Base
  validates :name, presence: true
  has_many :teams
  scope :filter_by_name, lambda { |keyword|
    where("lower(name) LIKE ?", "%#{keyword.downcase}%" )
  }

  ##
  # Search method used by the index endpoint of the Clubs controller.

  def self.search(params = {})
    clubs = params[:club_ids].present? ? Club.find(params[:club_ids]) : Club.all
    clubs = clubs.filter_by_name(params[:keyword]) if params[:keyword]
    clubs
  end

end
