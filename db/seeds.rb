# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
post1 = Post.create(title: "public post", content: "content of public post", status: "public", user_id: -1)
post2 = Post.create(title: "private post", content: "content of private post", status: "private", user_id: -1)
post3 = Post.create(title: "deleted post", content: "content of deleted post", status: "deleted", user_id: -1)

guest = User.create(id: -1, name: "guest", email: "guest@demo.com", about: "for guest", password: "1234", password_confirmation: "1234")