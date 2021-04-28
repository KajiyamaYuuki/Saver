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

CSV.foreach('db/menu.csv', headers: true) do |info|
  Menu.create(
    title: info['title'],
    description: info['description'],
    price: info['price'],
    interval_hour: info['interval_hour'],
    reservationable: info['reservationable'],
    shop_id: info['shop_id']
  )
end

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

CSV.foreach('db/review.csv', headers: true) do |info|
  Review.create(
    content: info['content'],
    score: info['score'],
    user_id: info['user_id'],
    shop_id: info['shop_id']
  )
end

CSV.foreach('db/reservation.csv', headers: true) do |info|
  Reservation.create(
    start_scheduled_at: info['start_scheduled_at'],
    end_scheduled_at: info['end_scheduled_at'],
    menu_id: info['menu_id'],
    user_id: info['user_id']
  )
end
