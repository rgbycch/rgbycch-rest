class ScoreTypeSerializer < ActiveModel::Serializer

  attributes :id, :title, :url, :points

  def cache_key
    [object, scope]
  end
end
