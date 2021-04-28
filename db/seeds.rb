# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"


CSV.foreach('db/staff.csv', headers: true) do |info|
  Staff.create(
    name: info['name'],
    description: info['description'],
    role: info['role'],
    sex: info['sex'],
    work_history: info['work_history'],
    shop_id: info['shop_id']
  )
end
