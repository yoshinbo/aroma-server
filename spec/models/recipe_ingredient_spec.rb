# == Schema Information
#
# Table name: recipe_ingredients
#
#  id            :integer          not null, primary key
#  recipe_id     :integer          not null
#  ingredient_id :integer          not null
#  amount        :integer          default(0), not null
#  order         :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
