require 'test_helper'

class RatingTest < ActiveSupport::TestCase

  def setup
    @rating = ratings(:rating_one)
  end

  test 'valid rating' do
    assert @rating.valid?
  end

  test 'invalid without score' do
    @rating.score= nil
    refute @rating.valid?, 'rating is valid without a score'
    assert_not_nil @rating.errors[:name], 'no validation error for score present'
  end

  test 'uniqueness of rating per each users per kombucha' do
    duplicated_rating = Rating.new(user: @rating.user, kombucha: @rating.kombucha, score: 2)
    assert_not duplicated_rating.save, 'rating is not unique'
  end

  test 'invalid if score not between 1..5' do
    @rating.score = 6
    refute @rating.valid? 'rating is valid with score outside 1..5'
    assert_not_nil @rating.errors[:score]
  end

end
