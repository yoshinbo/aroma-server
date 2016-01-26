class Api::V1::LikeRecipeController < Api::ApplicationController
  validates :update do
    integer :id, required: true
  end

  validates :destroy do
    integer :id, required: true
  end

  def update
    recipe_id = params[:id]
    @recipe = Recipe.lock.find_by(id: recipe_id)
    raise Aroma::Error::RecipeNotFound unless @recipe.present?

    like = UserLikeRecipe.find_by(recipe_id: recipe_id, user_id: current_user.id)
    unless like.present? then
      UserLikeRecipe.create(
        recipe_id: recipe_id,
        user_id: current_user.id
      )
      @recipe.update(liked_num: @recipe.liked_num + 1)

      UserNotice.insert_type_like(@recipe.user_id, current_user, @recipe)
    end
  end

  def destroy
    recipe_id = params[:id]
    @recipe = Recipe.lock.find_by(id: recipe_id)
    raise Aroma::Error::RecipeNotFound unless @recipe.present?

    like = UserLikeRecipe.find_by(recipe_id: recipe_id, user_id: current_user.id)
    if like.present? then
      like.destroy
      @recipe.update(liked_num: @recipe.liked_num - 1) if @recipe.liked_num > 0
    end
  end

end
