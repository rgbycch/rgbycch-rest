##
# Ensures a Club is formatted correctly in API responses

class ClubSerializer < ActiveModel::Serializer

  attributes :id, :title, :url, :founded

  has_many :teams

  ##
  # Defines the caching key for a Club

  def cache_key
    [object, scope]
  end
end
