# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
User.destroy_all
Quiz.destroy_all
Question.destroy_all

User.create!(id:'1',
    name:'Admin',
    email: 'admin@quizapp.com',
    password: 'app@success',
    password_confirmation: 'app@success',
    isadmin: true)

(2..25).each do |id|
  User.create!(    
    id: id, 
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "password", 
    password_confirmation: "password",
    isadmin: false
)
end

(1..10).each do |id|
  Category.create!(
    id: id,
    title: Faker::Category.title, 
)
end

(1..20).each do |id|
  Quiz.create!(
    id: id,
    category_id: rand(1..10), 
    title: Faker::Quiz.title, 
)
end

(1..100).each do |id|
    question_option = Option.new
  Question.create!(
    id: id
    body: 
    quiz_id: (1..20)
  )
end

