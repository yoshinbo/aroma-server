# == Schema Information
#
# Table name: recipes
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  status      :integer          default(0), not null
#  title       :string(100)      default(""), not null
#  description :string(300)      default(""), not null
#  category_id :integer          default(0), not null
#  like_num    :integer          default(0), not null
#  comment_num :integer          default(0), not null
#  clip_num    :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Recipe < ActiveRecord::Base
end
