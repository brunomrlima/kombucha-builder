class Flight < ApplicationRecord
  has_many :flight_items
  has_many :kombuchas, through: :flight_items

  validates :name, uniqueness: true

  def to_h
    {
        "id": self.id,
        "name": self.name,
        "kombuchas": self.kombuchas do |kombucha|
            kombucha.to_h
        end
    }
  end
end
