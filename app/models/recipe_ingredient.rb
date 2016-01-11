# == Schema Information
#
# Table name: recipe_ingredients
#
#  id            :integer          not null, primary key
#  recipe_id     :integer          not null
#  ingredient_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class RecipeIngredient < ActiveRecord::Base
end
