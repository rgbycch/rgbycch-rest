class PlayerSerializer < ActiveModel::Serializer

  attributes :id, :first_name, :last_name, :nick_name, :dob, :email, :phone_number

  has_many :teams

  def cache_key
    [object, scope]
  end
end

