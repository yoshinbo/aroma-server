class Api::V1::RecipesController < Api::ApplicationController
  include RecipeManager

  validates :show do
    integer :id, required: true
  end

  validates :create do
    string :title, required: true
    string :description, required: true
    integer :category_id, required: true
    array :ingredients, required: true
  end

  validates :edit do
    integer :id, required: true
  end

  validates :update do
    integer :id, required: true
    string :title, required: true
    string :description, required: true
    integer :category_id, required: true
    array :ingredients, required: true
  end

  validates :destroy do
    integer :id, required: true
  end

  validates :like do
    integer :recipe_id, required: true
  end

  validates :unlike do
    integer :recipe_id, required: true
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    raise Aroma::Error::RecipeNotFound unless @recipe.present?
  end

  def create
    user = current_user

    category = Category.find_by_id(params[:category_id])
    raise Aroma::Error::CategoryNotFound unless category.present?

    @recipe = Recipe.create!(
      user_id: user.id,
      title: params[:title],
      description: params[:description],
      category_id: category.id
    )

    begin 
      update_recipe_ralation_models @recipe, params[:ingredients]
    rescue => e
      @recipe.destroy!
      raise Aroma::Error::CreateRecipeFailed
    end
  end

  def edit
    @recipe = Recipe.find_by(id: params[:id])
    raise Aroma::Error::RecipeNotFound unless @recipe.present?
    raise Aroma::Error::AuthenticationFailed\
      unless @recipe.user_id == current_user.id
  end

  def update

    @recipe = Recipe.lock.find_by(id: params[:id])
    raise Aroma::Error::RecipeNotFound unless @recipe.present?
    raise Aroma::Error::AuthenticationFailed\
      unless @recipe.user_id == current_user.id

    category = Category.find_by_id(params[:category_id])
    raise Aroma::Error::CategoryNotFound unless category.present?

    update_recipe_ralation_models @recipe, params[:ingredients]
    @recipe.update(
      title: params[:title],
      description: params[:description],
      category_id: category.id
    )
  end

  def destroy
    @recipe = Recipe.find_by(id: params[:id])
    raise Aroma::Error::RecipeNotFound unless @recipe.present?
    raise Aroma::Error::AuthenticationFailed\
      unless @recipe.user_id == current_user.id

    @recipe.update(
      status: Recipe.statuses[:deleted]
    )
  end

  def like
    recipe_id = params[:recipe_id]
    @recipe = Recipe.lock.find_by(id: recipe_id)
    raise Aroma::Error::RecipeNotFound unless @recipe.present?

    like = UserLikeRecipe.find_by(recipe_id: recipe_id, user_id: current_user.id)
    unless like.present? then
      UserLikeRecipe.create(
        recipe_id: recipe_id,
        user_id: current_user.id
      )
      @recipe.update(liked_num: @recipe.liked_num + 1)
    end
  end

  def unlike
    recipe_id = params[:recipe_id]
    @recipe = Recipe.lock.find_by(id: recipe_id)
    raise Aroma::Error::RecipeNotFound unless @recipe.present?

    like = UserLikeRecipe.find_by(recipe_id: recipe_id, user_id: current_user.id)
    if like.present? then
      like.destroy
      @recipe.update(liked_num: @recipe.liked_num - 1) if @recipe.liked_num > 0
    end
  end

end
