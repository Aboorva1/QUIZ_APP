class Quiz < ApplicationRecord
    belongs_to :user, optional: true
    has_many :questions, dependent: :destroy
    validates :title, presence: true
    has_many :user_answers, dependent: :destroy
end
