json.extract! recipe, *[:id, :user_id, :title, :description, :liked_num, :commented_num, :cliped_num, :created_at, :updated_at]
json.user do
  json.partial! 'api/partial/user', user: recipe.user
end
json.category do
  json.partial! 'api/partial/category', category: recipe.category
end
json.recipe_ingredients do
  json.array! recipe.recipe_ingredients do |recipe_ingredient|
    json.partial! 'api/partial/recipe_ingredient', recipe_ingredient: recipe_ingredient
  end
end
json.recipe_comments do
  json.array! recipe.recipe_comments do |recipe_comment|
    json.partial! 'api/partial/recipe_comment', recipe_comment: recipe_comment if recipe_comment.active?
  end
end
