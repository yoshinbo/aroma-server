# == Schema Information
#
# Table name: recipes
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  status        :integer          default(0), not null
#  title         :string(100)      default(""), not null
#  description   :string(300)      default(""), not null
#  category_id   :integer          default(0), not null
#  liked_num     :integer          default(0), not null
#  commented_num :integer          default(0), not null
#  cliped_num    :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Recipe < ActiveRecord::Base
  enum status: {active: 0, banned: 99, deleted: 1}

  has_many :recipe_comments, dependent: :delete_all
  has_many :recipe_ingredients, dependent: :delete_all

  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :category, class_name: 'Category', foreign_key: 'category_id'

  validates :title, presence: true
  validates :description, presence: true
  validates :category_id, presence: true

  scope :active, -> { where(status: self.statuses[:active]) }
  scope :fetch_normal, -> (count, max_id, min_id) {
    all.tap do |c|
      c.active
      c.limit!(count) if count.present?
      c.where!('id < ?', max_id) if max_id.present?
      c.where!('id > ?', min_id) if min_id.present?
    end
  }
end
