# frozen_string_literal: true

require 'test_helper'

class KombuchaTest < ActiveSupport::TestCase

  def setup
    @kombucha = kombuchas(:guinny_pop)
  end

  test 'valid kombucha' do
    assert @kombucha.valid?
  end

  test 'invalid without name' do
    @kombucha.name = nil
    refute @kombucha.valid?, 'kombucha is valid without a name'
    assert_not_nil @kombucha.errors[:name], 'no validation error with name present'
  end

  test 'invalid with invalid fizziness_level' do
    @kombucha.fizziness_level = "very high"
    refute @kombucha.valid?, 'kombucha is valid with an invalid fizziness_level'
    assert_not_nil @kombucha.errors[:name], 'no validation error with a valid fizziness level'
  end
end
