class Quiz < ApplicationRecord
    belongs_to :sub_category
    belongs_to :user, optional: true

    validates :title, presence: true, format: { with: /\A([a-zA-Z]+\s)*[a-zA-Z]+\z/ }
    validates :minutes, presence: true

    has_many :questions, dependent: :destroy
    has_many :user_answers, dependent: :destroy
    has_many :user_quizzes, dependent: :destroy

end

