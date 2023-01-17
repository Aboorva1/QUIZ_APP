class SubCategory < ApplicationRecord
    belongs_to :category
    has_many :quizzes, dependent: :destroy
    
    validates :title, presence: true, length: { in: 5..20 }, :uniqueness => true
    validates_format_of :title, :with => /\A([a-zA-Z]+\s)*[a-zA-Z]+\z/
end
