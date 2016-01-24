# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'
# TODO : - 一回しかたたけないので要修正
CSV.foreach('db/seeds/categories.csv') do |row|
  Category.create(
    :id => row[0],
    :name => row[1],
    :status => row[2]
  )
end
