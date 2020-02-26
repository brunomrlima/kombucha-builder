# frozen_string_literal: true

class Kombucha < ApplicationRecord
  include Filterable
  scope :filter_by_fizziness_level, -> (fizziness_level) { where(fizziness_level: fizziness_level) }
  # scope :filter_by_caffeine_free, -> (caffeine_free) { joins(:ingredients).where("ingredients.caffeine_free = ?", caffeine_free) }
  # scope :filter_by_vegan, -> (vegan) { where(vegan: vegan) }

  has_many :recipe_items
  has_many :ingredients, through: :recipe_items

  validates :name, presence: true
  validates :fizziness_level, inclusion: { in: %w( high medium low ) }

  def to_h
    {
      "id": self.id,
      "name": self.name,
      "fizziness_level": self.fizziness_level,
      "ingredients": self.ingredients.map(&:name)
    }
  end

  def self.filter_by_caffeine_free(caffeine_free)
    filter_by_attribute("caffeine_free", caffeine_free)
  end

  def self.filter_by_vegan(vegan)
    filter_by_attribute("vegan", vegan)
  end

  def self.filter_by_attribute(attribute, value)
    value = JSON.parse(value)
    if value
      where.not(id: Kombucha.includes(:ingredients).where(ingredients: {id: Ingredient.return_list_of_ingredients_ids_with(attribute, !value)}))
    else
      where(id: Kombucha.includes(:ingredients).where(ingredients: {id: Ingredient.return_list_of_ingredients_ids_with(attribute, value)}))
    end
  end
end
