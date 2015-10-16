##
# Defines all attributes for a score type in the system. An example type of score is a 'try', 'penalty' or 'drop goal'

class ScoreType < ActiveRecord::Base
  extend Searchable
  validates :title, presence: true
  validates :points, numericality: { greater_than_or_equal_to: 0 },
            presence: true
  scope :filter_by_title, lambda { |keyword| where("lower(title) LIKE ?", "%#{keyword.downcase}%" ) }

  def self.id_params_identifier
    :score_type_ids
  end

end
