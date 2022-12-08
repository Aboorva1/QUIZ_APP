class User < ApplicationRecord
  
  validates_format_of :email, :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/i
  has_many :quizzes, :dependent => :destroy
  has_many :user_answers, :dependent => :destroy
  has_many :user_quizzes, :dependent => :destroy
  has_one_attached :image, :dependent => :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
