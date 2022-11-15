class Question < ApplicationRecord
	belongs_to :quiz
    validates :body, presence: true
    has_many :options, dependent: :destroy
    accepts_nested_attributes_for :options, allow_destroy: true
    has_many :user_answers, dependent: :destroy
    
end
