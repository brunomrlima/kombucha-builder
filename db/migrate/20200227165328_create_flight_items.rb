class CreateFlightItems < ActiveRecord::Migration[5.2]
  def change
    create_table :flight_items do |t|
      t.references :kombucha, foreign_key: true
      t.references :flight, foreign_key: true
    end
  end
end
