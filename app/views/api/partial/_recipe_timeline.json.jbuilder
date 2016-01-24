json.extract! recipe_timeline, *[:recipe_id, :type, :sort_value]
json.recipe do
  json.partial! 'api/partial/recipe', recipe: recipe_timeline.recipe
end
