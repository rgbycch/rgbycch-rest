class TeamSerializer < ActiveModel::Serializer

  attributes :id, :title

  has_many :players
  has_one :club

  def cache_key
    [object, scope]
  end
end
