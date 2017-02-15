# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(user_name:  "TestUser",
             email: "example@test.com",
             password:              "foobar",
             password_confirmation: "foobar")

99.times do |n|
  username  = Faker::Name.name[3..16]
  email = "example-#{n+1}@test.com"
  password = "password"
  User.create!(user_name: username,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(3)
50.times do
  caption = Faker::Lorem.sentence(5)
  image = File.open(File.join(Rails.root, "app/assets/images/default-avatar.jpg"))
  users.each { |user| user.posts.create!(caption: caption, image: image) }
end

users = User.order(:created_at).take(5)
post = Post.last
20.times do
  content = Faker::Lorem.sentence(2)
  users.each { |user| user.comments.create!(content: content, post_id: post.id) }
end

users = User.all
post = Post.last
users.each do |user|
  post.votes_for.up.by_type(user)
end

users = User.all
user  = User.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed.id) }
followers.each { |follower| follower.follow(user.id) }
