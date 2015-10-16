##
# Ensures a player is formatted correctly in API responses

class PlayerSerializer < ActiveModel::Serializer

  attributes :id, :first_name, :last_name, :nick_name, :dob, :email, :phone_number

  has_many :teams

  ##
  # Defines the caching key for a player

  def cache_key
    [object, scope]
  end
end

