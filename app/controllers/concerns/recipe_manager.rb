module RecipeManager
  extend ActiveSupport::Concern

  def update_recipe_ralation_models(recipe, ingredients_array)
    ingredients = []
    recipe_ingredient_map = {}

    ingredients_array.each do |ingredient|
      _ingredient = nil
      if ingredient[:id]
        _ingredient = Ingredient.find(ingredient[:id])
        raise Aroma::Error::IngredientNotFound unless _ingredient
      elsif ingredient[:name]
        _ingredient = Ingredient.find_or_create_by(
          name: ingredient[:name]
        ).tap do |d|
          d.save
        end
      end
      recipe_ingredient_map[_ingredient.id] = {
        amount: ingredient[:amount],
        order: ingredient[:order]
      }
      ingredients << _ingredient
    end
    raise Aroma::Error::IngredientNotFound unless ingredients.count > 0

    RecipeIngredient.delete_all(recipe_id: recipe.id)
    RecipeIngredient.transaction do
      recipe_ingredients = []
      ingredients.each do |ingredient|
        _ingredient = recipe_ingredient_map[ingredient.id]
        recipe_ingredients << RecipeIngredient.new(
          recipe_id: recipe.id,
          ingredient_id: ingredient.id,
          amount: _ingredient[:amount],
          order: _ingredient[:order]
        )
      end
      RecipeIngredient.import recipe_ingredients
    end
  end

end
