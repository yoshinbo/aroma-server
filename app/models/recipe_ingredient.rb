# == Schema Information
#
# Table name: recipe_ingredients
#
#  id            :integer          not null, primary key
#  recipe_id     :integer          not null
#  ingredient_id :integer          not null
#  amount        :integer          default(0), not null
#  order         :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe, class_name: 'Recipe', foreign_key: 'recipe_id'
  belongs_to :ingredient, class_name: 'Ingredient', foreign_key: 'ingredient_id'
end
