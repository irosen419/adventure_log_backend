class Animal < ApplicationRecord
    has_many :encounters
    has_many :trips, through: :encounters
end
