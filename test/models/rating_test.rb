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
  #
  # test 'invalid with invalid base' do
  #   @ingredient.base = nil
  #   refute @ingredient.valid?, 'ingredient is valid with an invalid base'
  #   assert_not_nil @ingredient.errors[:base], 'no validation error with a valid base'
  # end
  #
  # test 'invalid with invalid caffeine_free' do
  #   @ingredient.caffeine_free = nil
  #   refute @ingredient.valid?, 'ingredient is valid with an invalid caffeine_free'
  #   assert_not_nil @ingredient.errors[:caffeine_free], 'no validation error with a valid caffeine_free'
  # end
  #
  # test 'invalid with invalid vegan' do
  #   @ingredient.vegan = nil
  #   refute @ingredient.valid?, 'ingredient is valid with an invalid vegan'
  #   assert_not_nil @ingredient.errors[:vegan], 'no validation error with a valid vegan'
  # end

end
