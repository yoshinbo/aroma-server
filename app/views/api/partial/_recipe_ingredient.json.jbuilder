json.extract! recipe_ingredient, *[:id, :recipe_id, :ingredient_id, :amount, :order, :created_at, :updated_at]
json.ingredient do
  json.partial! 'api/partial/ingredient', ingredient: recipe_ingredient.ingredient
end
