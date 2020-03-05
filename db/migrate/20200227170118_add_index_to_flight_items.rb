class AddIndexToFlightItems < ActiveRecord::Migration[5.2]
  def change
    add_index :flight_items, [:flight_id, :kombucha_id], unique: true
  end
end
