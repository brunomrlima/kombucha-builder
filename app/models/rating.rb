class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :kombucha

  validates :score, presence: true
  validates :user_id, uniqueness: {scope: :kombucha_id, message: 'Users can only have 1 rating per kombucha.'}
end
