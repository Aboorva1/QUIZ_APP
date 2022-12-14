class Quiz < ApplicationRecord
    belongs_to :category
    belongs_to :user, optional: true

    validates :title, presence: true
    validates_format_of :title, :with => /\A([a-zA-Z]+\s)*[a-zA-Z]+\z/
    validates :minutes, presence: true

    has_many :questions, dependent: :destroy
    has_many :user_answers, dependent: :destroy
    has_many :user_quizzes, dependent: :destroy

end

