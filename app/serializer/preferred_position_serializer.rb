class PreferredPositionSerializer < ActiveModel::Serializer

  attributes :id, :preference

  has_one :player
  has_one :player_position

  def cache_key
    [object, scope]
  end
end
