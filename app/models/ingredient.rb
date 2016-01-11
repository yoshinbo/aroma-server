# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  status     :integer          default(0), not null
#  name       :string(100)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients
end
