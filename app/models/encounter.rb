class Encounter < ApplicationRecord
  belongs_to :trip
  belongs_to :animal

  validates :animal_id, presence: true

  has_one_attached :photo
end
