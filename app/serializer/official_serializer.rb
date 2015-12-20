##
# Ensures an Official is formatted correctly in API responses

class OfficialSerializer < ActiveModel::Serializer

  attributes :id, :title, :url

  ##
  # Defines the caching key for an Official

  def cache_key
    [object, scope]
  end
end
