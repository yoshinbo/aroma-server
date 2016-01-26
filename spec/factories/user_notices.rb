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

FactoryGirl.define do
  factory :user_notice do
    
  end

end
