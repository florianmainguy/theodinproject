# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all

15.times do |index|
  password = Faker::Internet.password
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  full_name = first_name + "." + last_name

  User.create!(first_name: first_name,
               last_name: last_name,
               email: Faker::Internet.email(full_name),
               password: password,
               password_confirmation: password)
end

User.create!(first_name: 'Jean-Claude',
             last_name: 'Van Damne',
             email: 'jeanclaude@vandamne.com',
             password: 'kickboxer',
             password_confirmation: 'kickboxer')

User.create!(first_name: 'Chuck',
             last_name: 'Norris',
             email: 'chuck@norris.com',
             password: 'deltaforce',
             password_confirmation: 'deltaforce')

p "Created #{User.count} users"
