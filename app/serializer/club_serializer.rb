##
# Ensures a club is formatted correctly in API responses

class ClubSerializer < ActiveModel::Serializer

  attributes :id, :name, :url, :founded

  has_many :teams

  ##
  # Defines the caching key for a club

  def cache_key
    [object, scope]
  end
end
