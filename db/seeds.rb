# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD'],
  password_confirmation: ENV['ADMIN_PASSWORD'],
  first_name: ENV['ADMIN_FIRST_NAME'],
  last_name: ENV['ADMIN_LAST_NAME'],
  username: ENV['ADMIN_USERNAME'],
  role: 'admin'
)

ApiUser.create(
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD'],
  password_confirmation: ENV['ADMIN_PASSWORD'],
)

# Create 999 random example users
999.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  username = Faker::Internet.username(specifier: first_name + " " + last_name, separators: %w())
  email = Faker::Internet.email(name: first_name + " " + last_name)
  password = "Demo1234!!"
  User.create!(
    email: email,
    password: password,
    password_confirmation: password,
    first_name: first_name,
    last_name: last_name,
    username: username,
    role: 'customer'
  )
end