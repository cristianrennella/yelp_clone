# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Business.create(name: "Mc Donald's", address: "123 Collins", food_type: "burgers")
Business.create(name: "Pizza Hut", address: "456 Lincols", food_type: "pizzas")
Business.create(name: "Chipotle", address: "678 Flowers St", food_type: "burritos")

User.create(email: "cristian@gmail.com", password: "password")

Review.create(description: "bla bla bla ...", user_id: "1", business_id: "1")
Review.create(description: "another reviews bla bla bla ...", user_id: "1", business_id: "2")
Review.create(description: "yet another reviews bla bla bla ...", user_id: "1", business_id: "2")
Review.create(description: "yes, you are right, yet another reviews bla bla bla ...", user_id: "1", business_id: "3")