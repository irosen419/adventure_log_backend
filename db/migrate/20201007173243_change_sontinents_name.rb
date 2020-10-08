class ChangeSontinentsName < ActiveRecord::Migration[6.0]
  def change
    rename_column :trips, :sontinent, :continent
  end
end
