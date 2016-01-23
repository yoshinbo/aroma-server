# == Schema Information
# This table is not exist
# Table name: recipe_timeline
#
#  recipe_id  :integer
#  recipe     :RecipeClass
#  type       :integer
#  sort_value :integer

class RecipeTimeline
  attr_accessor :recipe_id, :recipe, :type, :sort_value

  PAGER_COUNT = 25
  PAGER_COUNT.freeze

  def initialize(recipe, type, sort_value)
    @recipe_id = recipe.id
    @recipe = recipe
    @type = type
    @sort_value = sort_value
  end

  class << self
    def initializer(recipes, type, sort_key)
      timelines = []
      recipes.each do |recipe|
        timelines << self.new(recipe, type, recipe.send("#{sort_key}"))
      end
      return timelines
    end

    # 通常のタイムライン
    def get_normal(user, max_id = nil, min_id = nil)
      recipes = Recipe.fetch_normal(PAGER_COUNT, max_id, min_id).order('id desc')
      return initializer(recipes, 'normal', 'created_at')
    end
  end
end
