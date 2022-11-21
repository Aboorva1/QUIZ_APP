class User < ApplicationRecord
  has_many :quizzes
  has_many :user_answers
  has_many :user_quizzes
  has_one_attached :image, :dependent => :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
