class Question < ApplicationRecord
	belongs_to :quiz
    validates :body, presence: true
    has_many :options, dependent: :destroy
    has_many :user_answers, dependent: :destroy
end
