class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :my_trips, :my_encounters

  def my_trips
    object.trips
  end

  def my_encounters
    object.encounters.map{|encounter| EncounterSerializer.new(encounter)}
  end

  def following
    object.followings.map { |user| UserSerializer.new(user) }
  end

end
