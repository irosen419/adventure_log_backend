class RemoveImagesArrayFromEncounters < ActiveRecord::Migration[6.0]
  def change
    remove_column :encounters, :photos
  end
end
