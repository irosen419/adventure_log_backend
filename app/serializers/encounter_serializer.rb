class EncounterSerializer < ActiveModel::Serializer
  attributes :id, :trip_id, :animal_id, :animal_scientific_name, :animal_common_name, :time_of_day, :weather_conditions, :notes, :encounter_images, :username, :user_id, :destination

  def animal_scientific_name
    object.animal.scientific_name
  end

  def encounter_images
    object.images
  end

  def username
    object.trip.user.username
  end

  def user_id
    object.trip.user_id
  end

  def destination
    object.trip.destination
  end

  def animal_common_name
    object.animal.common_name
  end
end