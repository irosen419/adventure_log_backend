class TripSerializer < ActiveModel::Serializer
  attributes :id, :destination, :continent, :travel_date, :my_encounters

  def my_encounters
    object.encounters.map{|encounter| EncounterSerializer.new(encounter)}
  end
end
