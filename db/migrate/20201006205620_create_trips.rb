class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :destination
      t.string :continent
      t.datetime :travel_date

      t.timestamps
    end
  end
end
