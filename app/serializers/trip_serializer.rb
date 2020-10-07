class TripSerializer < ActiveModel::Serializer
  attributes :id, :destination, :continent, :travel_date
end
