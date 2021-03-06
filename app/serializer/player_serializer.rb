##
# Ensures a Player is formatted correctly in API responses

class PlayerSerializer < ActiveModel::Serializer

  attributes :id, :first_name, :last_name, :nick_name, :dob, :email, :phone_number

  ##
  # Defines the caching key for a Player

  def cache_key
    [object, scope]
  end
end

