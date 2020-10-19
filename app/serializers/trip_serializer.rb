class TripSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :my_user, :destination, :continent, :date, :my_encounters

  def date
    if object.travel_date
      object.travel_date.strftime("%A, %B %d, %Y")
    end
  end

  def my_encounters
    object.encounters.map{|encounter| EncounterSerializer.new(encounter)}
  end

  def my_user
    User.find(object.user_id)["username"]
  end
end
