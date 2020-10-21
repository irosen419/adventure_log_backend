class AddImagesToEncounters < ActiveRecord::Migration[6.0]
  def change
    add_column :encounters, :photos, :text, array: true, default: []
  end
end
