class Api::V1::CommentRecipeController < Api::ApplicationController
  validates :index do
    integer :recipe_id, required: true
  end

  validates :create do
    integer :recipe_id, required: true
    string :comment, in: 1..300, required: true
  end

  validates :destroy do
    integer :id, required: true
  end

  def index
    @recipe_comments = RecipeComment.active.where('recipe_id = ?', params[:recipe_id])
  end

  def create
    @recipe = Recipe.lock.active.find_by(id: params[:recipe_id])
    raise Aroma::Error::RecipeNotFound unless @recipe.present?

    RecipeComment.create!(
      recipe_id: @recipe.id,
      user_id: current_user.id,
      comment: params[:comment]
    )
    @recipe.update(commented_num: @recipe.commented_num + 1)
  end 

  def destroy
    recipe_comment = RecipeComment.find_by(id: params[:id])
    raise Aroma::Error::RecipeCommentNotFound unless recipe_comment.present?
    raise Aroma::Error::AuthenticationFailed\
      unless recipe_comment.user_id == current_user.id

    @recipe = Recipe.lock.find_by(id: recipe_comment.recipe_id)
    raise Aroma::Error::RecipeNotFound unless @recipe.present?

    recipe_comment.update(
      status: RecipeComment.statuses[:deleted]
    )
    @recipe.update(commented_num: @recipe.commented_num - 1) if @recipe.commented_num > 0
  end

end
