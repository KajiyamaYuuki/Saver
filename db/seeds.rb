# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"

CSV.foreach('db/user.csv', headers: true) do |row|
  User.create(
    name: row['name'],
    email: row['email'],
    password: row['password'],
    password_confirmation: row['password'],
    is_admin: row['is_admin'],
    is_owner: row['is_owner']
  )
end

CSV.foreach('db/shop.csv', headers: true) do |info|
  Shop.create(
    name: info['name'],
    description: info['description'],
    post_code: info['post_code'],
    prefecture_code: info['prefecture_code'],
    address_city: info['address_city'],
    address_street: info['address_street'],
    phone_number: info['phone_number'],
    email: info['email'],
    url: info['url'],
    user_id: info['user_id']
  )
end
