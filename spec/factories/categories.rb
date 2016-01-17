# == Schema Information
#
# Table name: categories
#
#  id     :integer          not null, primary key
#  name   :string(100)      default(""), not null
#  status :integer          default(1), not null
#

FactoryGirl.define do
  factory :category do
    
  end

end
