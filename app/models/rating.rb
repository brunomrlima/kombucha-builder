class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :kombucha

  validates :score, presence: true
  validates :user_id, uniqueness: {scope: :kombucha_id, message: 'Users can only have 1 rating per kombucha.'}
  validates :score, inclusion: { in: 1..5, message: 'Score has to be between 1 and 5' }

  def to_h
    {
        "id": self.id,
        "kombucha": self.kombucha.name,
        "score": self.score
    }
  end
end
