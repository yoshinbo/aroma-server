json.extract! recipe_comment, *[:id, :recipe_id, :comment, :created_at, :updated_at]
json.status recipe_comment.status_value
json.user do
  json.partial! 'api/partial/user', user: recipe_comment.user
end
