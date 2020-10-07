class EncounterSerializer < ActiveModel::Serializer
  attributes :id, :trip_id, :animal_id, :time_of_day, :weather_conditions, :notes
end
