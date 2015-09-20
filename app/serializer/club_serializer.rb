class ClubSerializer < ActiveModel::Serializer

  attributes :id, :name, :url, :founded

  has_many :teams

  def cache_key
    [object, scope]
  end
end
