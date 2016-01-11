# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  recipe_id  :integer          not null
#  status     :integer          default(0), not null
#  name       :string(100)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
