# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  facebook_id      :string(128)      default(""), not null
#  name             :string(100)      default(""), not null
#  status           :integer          default(0), not null
#  encrypted_secret :string(255)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class User < ActiveRecord::Base
  SEEDS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze
  SEPARATOR = '-'

  enum status: {active: 0, banned: 1}
  has_many :devices
  has_one :user_attributes
  has_many :user_settings
  has_many :user_clip_recipes
  has_many :user_like_recipes
  has_many :recipes
  has_many :recipe_comments

end
