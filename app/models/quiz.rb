class Quiz < ApplicationRecord
    belongs_to :category
    belongs_to :user, optional: true
    validates :title, presence: true, length: { in: 8..20 }
    has_many :questions, dependent: :destroy
    has_many :user_answers, dependent: :destroy
end
