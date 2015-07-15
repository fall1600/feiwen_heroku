# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
guest = User.create(id: 1, name: "guest", email: "guest@demo.com", about: "for guest", password: "1234", password_confirmation: "1234")

user1 = User.create(id: 2, name: "fall1600", email: "fall1600@demo.com", about: "developer", password: "fjdkfjdk", password_confirmation: "fjdkfjdk")

post1 = Post.create(title: "public post", content: "content of public post", status: "public", user_id: 2)
post2 = Post.create(title: "private post", content: "content of private post", status: "private", user_id: 2)
post3 = Post.create(title: "deleted post", content: "content of deleted post", status: "deleted", user_id: 2)

