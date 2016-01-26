# == Schema Information
#
# Table name: user_like_recipes
#
#  id         :integer          not null, primary key
#  recipe_id  :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserLikeRecipe < ActiveRecord::Base
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  validates :recipe_id, presence: true
  validates :user_id, presence: true
end
