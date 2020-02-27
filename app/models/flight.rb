class Flight < ApplicationRecord
  has_many :kombuchas, through: :flight_items
end
