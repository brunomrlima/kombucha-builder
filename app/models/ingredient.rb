# frozen_string_literal: true

class Ingredient < ApplicationRecord
  has_many :recipe_items
  has_many :kombuchas, through: :recipe_items

  validates :name, presence: true
  validates :base, inclusion: { in: [ true, false ] }
  validates :caffeine_free, inclusion: { in: [ true, false ] }
  validates :vegan, inclusion: { in: [ true, false ] }

  def self.return_list_of_ingredients_ids_with(attribute, value)
    where("#{attribute} = ?", value).pluck(:id)
  end

  def self.select_n_different_bases(n_samples)
    where(base: true).pluck(:id).sample(n_samples)
  end

end
