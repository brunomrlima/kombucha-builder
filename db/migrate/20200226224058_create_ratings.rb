class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.references :user, foreign_key: true
      t.references :kombucha, foreign_key: true
      t.integer :score, :null => false

      t.timestamps
    end
  end
end
