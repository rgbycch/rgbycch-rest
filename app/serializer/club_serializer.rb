##
# Ensures a club is formatted correctly in API responses

class ClubSerializer < ActiveModel::Serializer

  attributes :id, :title, :url, :founded

  ## initialise the teams without clubs!
  has_many :teams, :serializer => ClublessTeamSerializer

  ##
  # Defines the caching key for a club

  def cache_key
    [object, scope]
  end

end
