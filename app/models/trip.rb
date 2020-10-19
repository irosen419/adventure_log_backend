class Trip < ApplicationRecord
  belongs_to :user
  has_many :encounters, :dependent => :delete_all
  has_many :animals, through: :encounters

  validates :destination, :continent, presence: true

  def username
    self.user.username
  end
end
