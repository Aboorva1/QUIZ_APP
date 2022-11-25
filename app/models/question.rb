class Question < ApplicationRecord
	belongs_to :quiz
  has_many :options, dependent: :destroy
  has_many :user_answers, dependent: :destroy

  accepts_nested_attributes_for :options, allow_destroy: true

  validates :body, presence: true
  
end
