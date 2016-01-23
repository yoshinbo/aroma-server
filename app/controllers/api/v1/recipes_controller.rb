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

    @recipe = Recipe.find_by(id: params[:id])
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
end
