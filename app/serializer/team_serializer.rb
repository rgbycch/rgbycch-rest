##
# Ensures a Team is formatted correctly in API responses

class TeamSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :players
  has_one :club

  ##
  # Defines the caching key for a Team

  def cache_key
    [object, scope]
  end
end
