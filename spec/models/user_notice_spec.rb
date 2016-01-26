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

require 'rails_helper'

RSpec.describe UserNotice, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
