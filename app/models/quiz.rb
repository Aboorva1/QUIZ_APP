class Quiz < ApplicationRecord
    belongs_to :sub_category
    belongs_to :user, optional: true

    validates :title, presence: true, format: { with: /\A([a-zA-Z]+\s)*[a-zA-Z]+\z/ }, length: { in: 5..20 }
    validates :minutes, presence: true, :numericality => {:only_integer => true}

    has_many :questions, dependent: :destroy
    has_many :user_answers, dependent: :destroy
    has_many :user_quizzes, dependent: :destroy
    has_one_attached :quiz_image, :dependent => :destroy
end

