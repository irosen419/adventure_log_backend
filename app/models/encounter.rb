class Encounter < ApplicationRecord
  belongs_to :trip
  belongs_to :animal

  has_one_attached :photo
end
