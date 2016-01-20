class Api::V1::RecipesController < Api::ApplicationController

  validates :create do
    string :title, required: true
    string :description, required: true
    integer :category_id, required: true
    array :ingredients, required: true
  end

  def index
  end

  def show
  end

  def create
    user = current_user

    category = Category.find_by_id(params[:category_id])
    raise Aroma::Error::CategoryNotFound unless category.present?

    ingredients = []
    recipe_ingredient_map = {}
    logger.debug()
    params[:ingredients].each do |ingredient|
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

    @recipe = Recipe.create!(
      user_id: user.id,
      title: params[:title],
      description: params[:description],
      category_id: category.id
    )

    begin 
      RecipeIngredient.transaction do
        recipe_ingredients = []
        ingredients.each do |ingredient|
          _ingredient = recipe_ingredient_map[ingredient.id]
          recipe_ingredients << RecipeIngredient.new(
            recipe_id: @recipe.id,
            ingredient_id: ingredient.id,
            amount: _ingredient[:amount],
            order: _ingredient[:order]
          )
        end
        RecipeIngredient.import recipe_ingredients
      end
    rescue => e
      @recipe.destroy!
      raise Aroma::Error::CreateRecipeFailed
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
