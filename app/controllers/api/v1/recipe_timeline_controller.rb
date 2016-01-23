class Api::V1::RecipeTimelineController < Api::ApplicationController

  validates :normal do
    integer :max_id
    integer :min_id
  end

  def normal
    @recipe_timelines = RecipeTimeline.get_normal(
      current_user,
      params[:max_id],
      params[:min_id]
    )
  end
end
