class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :my_trips

  def my_trips
    object.trips
  end

  def followings
    object.followings.map { |user| UserSerializer.new(user) }
  end

end
