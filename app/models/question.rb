class Question < ApplicationRecord
	belongs_to :quiz
  has_many :options, dependent: :destroy
  has_many :user_answers, dependent: :destroy

  accepts_nested_attributes_for :options, allow_destroy: true

  validates :body, presence: true
  validate :options_count
  
  private 

  def options_count   
    unless options.count == 4
      errors.add(:base, "Question should have exactly 4 options")
    end 
    unless Option.where(question_id: self.id, is_correct_answer: "true").count == 1
      errors.add(:base, "Only one option can be set true")
    end
  end
end
