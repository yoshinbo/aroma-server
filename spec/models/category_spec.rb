# == Schema Information
#
# Table name: categories
#
#  id     :integer          not null, primary key
#  name   :string(100)      default(""), not null
#  status :integer          default(1), not null
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
