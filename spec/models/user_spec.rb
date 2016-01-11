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

require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
