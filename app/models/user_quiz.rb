class UserQuiz < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  has_one_attached :image  
end
