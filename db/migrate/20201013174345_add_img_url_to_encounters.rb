class AddImgUrlToEncounters < ActiveRecord::Migration[6.0]
  def change
    add_column :encounters, :img_url, :string
  end
end
