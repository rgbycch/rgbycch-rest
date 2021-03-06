##
# Ensures a User is formatted correctly in API responses

class UserSerializer < ActiveModel::Serializer

  attributes :id, :email, :auth_token

  ##
  # Defines the caching key for a User

  def cache_key
    [object, scope]
  end
end