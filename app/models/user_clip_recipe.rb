# == Schema Information
#
# Table name: user_clip_recipes
#
#  id         :integer          not null, primary key
#  recipe_id  :integer          not null
#  user_id    :integer          not null
#  status     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserClipRecipe < ActiveRecord::Base
end
