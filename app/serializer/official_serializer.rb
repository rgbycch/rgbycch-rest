##
# Ensures an official is formatted correctly in API responses

class OfficialSerializer < ActiveModel::Serializer

  attributes :id, :title, :url

  ##
  # Defines the caching key for an official

  def cache_key
    [object, scope]
  end
end