class TripSerializer < ActiveModel::Serializer
  attributes :id, :destination, :continent, :date, :my_encounters

  def date
    object.travel_date.strftime("%A, %B %d, %Y")
  end

  def my_encounters
    object.encounters.map{|encounter| EncounterSerializer.new(encounter)}
  end
end
