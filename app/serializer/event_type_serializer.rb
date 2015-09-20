class EventTypeSerializer < ActiveModel::Serializer

  attributes :id, :title, :url

  def cache_key
    [object, scope]
  end
end
