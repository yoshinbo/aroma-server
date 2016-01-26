class Api::V1::ClipRecipeController < Api::ApplicationController
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

    clip = UserClipRecipe.find_by(recipe_id: recipe_id, user_id: current_user.id)
    unless clip.present? then
      UserClipRecipe.create(
        recipe_id: recipe_id,
        user_id: current_user.id
      )
      @recipe.update(cliped_num: @recipe.cliped_num + 1)

      UserNotice.insert_type_clip(@recipe.user_id, current_user, @recipe)
    end
  end

  def destroy
    recipe_id = params[:id]
    @recipe = Recipe.lock.find_by(id: recipe_id)
    raise Aroma::Error::RecipeNotFound unless @recipe.present?

    clip = UserClipRecipe.find_by(recipe_id: recipe_id, user_id: current_user.id)
    if clip.present? then
      clip.destroy
      @recipe.update(cliped_num: @recipe.cliped_num - 1) if @recipe.cliped_num > 0
    end
  end

end
