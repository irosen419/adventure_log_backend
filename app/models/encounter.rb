class Encounter < ApplicationRecord
  belongs_to :trip
  belongs_to :animal

  validates :animal_id, presence: true

  def save_image(image, encounter)
    name = File.basename(image)
    obj = S3_BUCKET.object(name)
    obj.upload_file(image)
    encounter.photos.push(obj.public_url.to_s)
  end
end
