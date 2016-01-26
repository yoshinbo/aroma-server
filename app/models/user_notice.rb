# == Schema Information
#
# Table name: user_notices
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  from_id     :integer          not null
#  notice_type :integer          default(0), not null
#  content_id  :integer          not null
#  content     :string(100)      default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserNotice < ActiveRecord::Base
  enum notice_type: {news: 0, comment: 1, like: 2, clip: 3}

  scope :fetch_related, ->(user_id) { where("user_id = ? or user_id = 0", user_id) }

  class << self
    def insert_type_news(content_id, content)
      create(
        user_id: 0,
        from_id: 0,
        notice_type: self.notice_types[:news],
        content_id: content_id,
        content: content,
      )
    end

    def insert_type_comment(user_id, from_user, recipe)
      return if user_id == from_user.id
      content = sprintf "%{from_user_name}さんが「%{recipe_title}」にコメントしました。",\
        from_user_name: from_user.name,\
        recipe_title: recipe.title

      create(
        user_id: user_id,
        from_id: from_user.id,
        notice_type: self.notice_types[:comment],
        content_id: recipe.id,
        content: content,
      )
    end

    def insert_type_like(user_id, from_user, recipe)
      return if user_id == from_user.id
      content = sprintf "%{from_user_name}さんが「%{recipe_title}」にLikeしました。",\
        from_user_name: from_user.name,\
        recipe_title: recipe.title

      create(
        user_id: user_id,
        from_id: from_user.id,
        notice_type: self.notice_types[:like],
        content_id: recipe.id,
        content: content,
      )
    end

    def insert_type_clip(user_id, from_user, recipe)
      return if user_id == from_user.id
      content = sprintf "%{from_user_name}さんが「%{recipe_title}」をクリップしました。",\
        from_user_name: from_user.name,\
        recipe_title: recipe.title

      create(
        user_id: user_id,
        from_id: from_user.id,
        notice_type: self.notice_types[:clip],
        content_id: recipe.id,
        content: content,
      )
    end
  end

  def about_news?
    type_value == self.class.notice_types[:news]
  end

  def about_recipe?
    !about_news?
  end

  def type_value
    self.class.notice_types[notice_type]
  end

end
