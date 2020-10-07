class Encounter < ApplicationRecord
  belongs_to :trip
  belongs_to :animal
end
