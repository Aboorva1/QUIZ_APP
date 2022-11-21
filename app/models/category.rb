class Category < ApplicationRecord
    has_many :quizzes, :dependent => :destroy
    validates :title, presence: true
end
