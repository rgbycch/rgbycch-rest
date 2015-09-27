##
# Defines all attributes for a club in the system.

class Club < ActiveRecord::Base
  extend Searchable
  validates :title, presence: true
  has_many :teams, dependent: :destroy
  scope :filter_by_title, lambda { |keyword| where("lower(title) LIKE ?", "%#{keyword.downcase}%" ) }

  def self.id_params_identifier
    :club_ids
  end

end
