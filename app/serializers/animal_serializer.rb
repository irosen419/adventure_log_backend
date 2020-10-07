class AnimalSerializer < ActiveModel::Serializer
  attributes :id, :scientific_name, :common_name
end
