class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :kombucha

  validates :score, presence: true
end
