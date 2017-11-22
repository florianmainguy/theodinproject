# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Post.destroy_all
Like.destroy_all
Comment.destroy_all
Friendship.destroy_all
FriendRequest.destroy_all

p "Creating users..."
15.times do |index|
  password = Faker::Internet.password
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  full_name = first_name + "." + last_name
  email = Faker::Internet.email(full_name)
  about = Faker::Lorem.sentence
  picture = Faker::LoremPixel.image("400x400")
  cover = Faker::LoremPixel.image("700x500")

  User.create!(first_name: first_name,
               last_name: last_name,
               email: email,
               about: about,
               remote_picture_url: picture,
               remote_cover_url: cover,
               password: password,
               password_confirmation: password)
end

User.create!(first_name: 'Jean-Claude',
             last_name: 'Van Damne',
             email: 'jeanclaude@vandamne.com',
             about: 'I now truly believe it is impossible for me to make a bad movie.',
             password: 'kickboxer',
             password_confirmation: 'kickboxer')

User.create!(first_name: 'Chuck',
             last_name: 'Norris',
             email: 'chuck@norris.com',
             about: "I don't initiate violence, I retaliate.",
             password: 'deltaforce',
             password_confirmation: 'deltaforce')

p "Created #{User.count} users"

p "Creating posts..."
User.all.each do |user|
  10.times do
    post = user.posts.build(body: Faker::Lorem.paragraph(10),
                    created_at: Faker::Date.between(4.days.ago, Time.now))
    post.save!
  end
end
