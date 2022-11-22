class User < ApplicationRecord
  has_many :quizzes, :dependent => :destroy
  has_many :user_answers, :dependent => :destroy
  has_many :user_quizzes, :dependent => :destroy
  has_one_attached :image, :dependent => :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
