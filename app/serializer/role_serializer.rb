##
# Ensures a Role is formatted correctly in API responses

class RoleSerializer < ActiveModel::Serializer

  attributes :id, :title, :url

  ##
  # Defines the caching key for a Role

  def cache_key
    [object, scope]
  end
end
