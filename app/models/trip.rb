class Trip < ApplicationRecord
  belongs_to :user
  has_many :encounters
  has_many :animals, through: :encounters
end
