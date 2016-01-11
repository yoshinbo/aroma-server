# == Schema Information
#
# Table name: user_settings
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  key        :integer          default(0), not null
#  value      :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserSetting < ActiveRecord::Base
end
