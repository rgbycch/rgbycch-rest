##
# Ensures a club is formatted correctly in API responses

class TeamlessClubSerializer < ActiveModel::Serializer

  attributes :id, :title, :url, :founded

  ##
  # Defines the caching key for a club

  def cache_key
    [object, scope]
  end

end
