class Option < ApplicationRecord
    belongs_to :question
    validates :choice, presence: true
    has_many :user_answers, dependent: :destroy  
end

