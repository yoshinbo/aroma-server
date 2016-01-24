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

class RecipeComment < ActiveRecord::Base
  enum status: {active: 0, banned: 99, deleted: 1}

  belongs_to :recipe, class_name: 'Recipe', foreign_key: 'recipe_id'
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  validates :recipe_id, presence: true
  validates :user_id, presence: true
  validates :comment, presence: true

  scope :active, -> { where(status: self.statuses[:active]) }

  def active?
    status_value == self.class.statuses[:active]
  end

  def status_value
    self.class.statuses[status]
  end
end
