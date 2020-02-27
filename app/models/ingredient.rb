# frozen_string_literal: true

class Ingredient < ApplicationRecord
  has_many :recipe_items
  has_many :kombuchas, through: :recipe_items

  scope :return_base, -> {where(base: true).last}

  validates :name, presence: true
  validates :base, inclusion: { in: [ true, false ] }
  validates :caffeine_free, inclusion: { in: [ true, false ] }
  validates :vegan, inclusion: { in: [ true, false ] }

  def self.return_list_of_ingredients_with(attribute, value)
    where("#{attribute} = ?", value)
  end

  def self.return_n_different_bases_ids(n_samples, selected_base_id = nil)
    where(base: true).where.not(id: selected_base_id).pluck(:id).sample(n_samples)
  end

end
