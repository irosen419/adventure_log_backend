class CreateEncounters < ActiveRecord::Migration[6.0]
  def change
    create_table :encounters do |t|
      t.belongs_to :trip, null: false, foreign_key: true
      t.belongs_to :animal, null: false, foreign_key: true
      t.string :time_of_day
      t.string :weather_conditions
      t.string :notes

      t.timestamps
    end
  end
end
