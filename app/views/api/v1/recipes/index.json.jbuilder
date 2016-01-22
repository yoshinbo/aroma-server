json.recipes do
  json.array! @recipes do |recipe|
    json.partial! 'api/partial/recipe', recipe: recipe
  end
end
