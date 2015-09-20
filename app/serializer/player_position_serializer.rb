class PlayerPositionSerializer < ActiveModel::Serializer

  attributes :id, :title, :url, :position_number

  def cache_key
    [object, scope]
  end
end
