# frozen_string_literal: true

require 'test_helper'

class IngredientTest < ActiveSupport::TestCase

  def setup
    @ingredient = ingredients(:white_tea)
  end

  test 'valid ingredient' do
    assert @ingredient.valid?
  end

  test 'invalid without name' do
    @ingredient.name = nil
    refute @ingredient.valid?, 'ingredient is valid without a name'
    assert_not_nil @ingredient.errors[:name], 'no validation error for name present'
  end

  test 'invalid with invalid base' do
    @ingredient.base = nil
    refute @ingredient.valid?, 'ingredient is valid with an invalid base'
    assert_not_nil @ingredient.errors[:base], 'no validation error with a valid base'
  end

  test 'invalid with invalid caffeine_free' do
    @ingredient.caffeine_free = nil
    refute @ingredient.valid?, 'ingredient is valid with an invalid caffeine_free'
    assert_not_nil @ingredient.errors[:caffeine_free], 'no validation error with a valid caffeine_free'
  end

  test 'invalid with invalid vegan' do
    @ingredient.vegan = nil
    refute @ingredient.valid?, 'ingredient is valid with an invalid vegan'
    assert_not_nil @ingredient.errors[:vegan], 'no validation error with a valid vegan'
  end

end
