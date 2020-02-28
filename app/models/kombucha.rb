# frozen_string_literal: true

class Kombucha < ApplicationRecord
  include Filterable
  scope :filter_by_fizziness_level, -> (fizziness_level) { where(fizziness_level: fizziness_level) }

  has_many :recipe_items
  has_many :ingredients, through: :recipe_items
  has_many :ratings
  has_many :flight_items

  validates :name, presence: true
  validates :fizziness_level, inclusion: { in: %w( high medium low ) }

  def to_h
    {
      "id": self.id,
      "name": self.name,
      "fizziness_level": self.fizziness_level,
      "average_score": self.average_score,
      "ingredients": self.ingredients.map(&:name)
    }
  end

  def self.filter_by_attribute(attribute, value)
    if attribute == "fizziness_level"
      self.filter_by_fizziness_level(value)
    elsif attribute == "caffeine_free" || attribute == "vegan"
      value = JSON.parse(value)
      if value
        where.not(id: Kombucha.includes(:ingredients).where(ingredients: {id: Ingredient.return_list_of_ingredients_with(attribute, !value)}))
      else
        where(id: Kombucha.includes(:ingredients).where(ingredients: {id: Ingredient.return_list_of_ingredients_with(attribute, value)}))
      end
    elsif attribute == "including"
      ingredients_ids = Ingredient.return_list_of_ingredients_from_list_of_names(value)
      self.where(id: Kombucha.includes(:ingredients).where(ingredients: {id: ingredients_ids}))
    elsif attribute == "not_including"
      ingredients_ids = Ingredient.return_list_of_ingredients_from_list_of_names(value)
      where.not(id: Kombucha.includes(:ingredients).where(ingredients: {id: ingredients_ids}))
    elsif attribute == "popularity"
      Kombucha.all.reject { |kombucha| kombucha.popularity < value.to_i }
    end
  end

  def average_score
    self.ratings.average(:score)
  end

  def self.n_samples_with_different_base(n_samples, selected_kombucha = nil)
    selected_base_id = selected_kombucha.try(:return_base_id)
    ingredients = Ingredient.return_n_different_bases_ids(n_samples, selected_base_id)
    kombuchas_list_ids = self.return_list_of_random_kombuchas_ids(ingredients)
    kombuchas_list_ids << selected_kombucha.id if selected_kombucha
    kombuchas_list_ids.sort
  end

  def self.return_list_of_random_kombuchas_ids(ingredients)
    kombuchas_list_ids = []
    ingredients.each do |base_id|
      kombuchas_list_ids << Kombucha.return_random_kombucha_id(base_id)
    end
    kombuchas_list_ids
  end

  def self.return_random_kombucha_id(base_id)
    self.where(id: self.includes(:ingredients).where(ingredients: {id: base_id})).order('RANDOM()').first.id
  end

  def return_base_id
    self.ingredients.return_base.id
  end

  def popularity
    kombucha_flight_items = self.flight_items.count
    n_flight_items = FlightItem.count
    ((kombucha_flight_items.to_f/n_flight_items)*100).ceil
  end

end
