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

require 'rails_helper'

RSpec.describe UserSetting, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
