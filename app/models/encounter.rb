class Encounter < ApplicationRecord
  belongs_to :trip
  belongs_to :animal

  validates :animal_id, presence: true

  has_many_attached :images
end
