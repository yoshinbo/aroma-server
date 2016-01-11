# == Schema Information
#
# Table name: recipe_comments
#
#  id         :integer          not null, primary key
#  recipe_id  :integer          not null
#  user_id    :integer          not null
#  status     :integer          default(0), not null
#  comment    :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe RecipeComment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
