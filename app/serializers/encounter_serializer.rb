class EncounterSerializer < ActiveModel::Serializer
  attributes :id, :trip_id, :animal_id, :animal_scientific_name, :animal_common_name, :time_of_day, :weather_conditions, :notes

  def animal_scientific_name
    object.animal.scientific_name
  end

  def animal_common_name
    object.animal.common_name
  end
end
