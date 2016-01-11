# == Schema Information
#
# Table name: user_attributes
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  introduction :string(300)      not null
#  url          :string(255)      not null
#  region_id    :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class UserAttribute < ActiveRecord::Base
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :region, class_name: 'Region', foreign_key: 'region_id'
end
