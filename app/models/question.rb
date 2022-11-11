class Question < ApplicationRecord
	belongs_to :quiz
    validates :body, presence: true
    has_many :options, dependent: :destroy
    accepts_nested_attributes_for :options, allow_destroy: true, reject_if: lambda {|attributes| attributes['option1'].blank?}
    has_many :user_answers, dependent: :destroy
    
end
