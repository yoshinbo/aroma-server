json.recipe_comments do
  json.array! @recipe_comments do |recipe_comment|
    json.partial! 'api/partial/recipe_comment', recipe_comment: recipe_comment
  end
end
