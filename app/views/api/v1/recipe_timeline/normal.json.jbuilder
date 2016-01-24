json.recipe_timelines do
  json.array! @recipe_timelines do |recipe_timeline|
    json.partial! 'api/partial/recipe_timeline', recipe_timeline: recipe_timeline
  end
end
