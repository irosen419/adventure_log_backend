class EncounterSerializer < ActiveModel::Serializer
  attributes :id, :trip_id, :animal_id, :animal_scientific_name, :animal_common_name, :time_of_day, :weather_conditions, :notes, :encounter_images

  def animal_scientific_name
    object.animal.scientific_name
  end

  def encounter_images
    object.images
    # byebug
  end


  def animal_common_name
    object.animal.common_name
  end
end
