class Option < ApplicationRecord
    belongs_to :question
    validates :option1, presence: true
    has_many :user_answers, dependent: :destroy  
end



