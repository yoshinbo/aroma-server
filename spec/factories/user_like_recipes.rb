# == Schema Information
#
# Table name: user_like_recipes
#
#  id         :integer          not null, primary key
#  recipe_id  :integer          not null
#  user_id    :integer          not null
#  status     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :user_like_recipe do
    
  end

end
