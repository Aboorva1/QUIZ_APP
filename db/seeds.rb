# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

User.destroy_all
Category.destroy_all
Quiz.destroy_all
Question.destroy_all
Option.destroy_all

User.create!(id:'1',
    name:'Admin',
    email: 'admin@quizapp.com',
    password: 'app@success',
    password_confirmation: 'app@success',
    is_admin: true)

5.times do
  User.create!(     
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "password", 
    password_confirmation: "password",
    is_admin: false
  )
end

5.times do
  category = Category.create!( 
    title: Faker::Lorem.word
  )

  5.times do
    quiz = Quiz.create!(
      category_id: category.id,
      category_name: category.title,
      title: Faker::Lorem.sentence(word_count: 2),
      minutes: 1
    )

    5.times do
      question = Question.create!(
        body: Faker::Lorem.sentence(word_count: 6),
        quiz_id: quiz.id
      )

      3.times do
        option = Option.create!(
          choice:Faker::Lorem.word,
          is_correct_answer: false,
          question_id: question.id
        )
      end
      option = Option.create!(
        choice:Faker::Lorem.word,
        is_correct_answer: true,
        question_id: question.id
      )
    end
  end
end


