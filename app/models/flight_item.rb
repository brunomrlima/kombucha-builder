class FlightItem < ApplicationRecord
  belongs_to :flight
  belongs_to :kombucha

  validates :flight_id, uniqueness: {scope: :kombucha_id, message: 'A Flight can not have two kombuchas with the same recipe.'}
end
