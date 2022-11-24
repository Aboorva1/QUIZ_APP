class Question < ApplicationRecord
	belongs_to :quiz
  validates :body, presence: true
  has_many :options, dependent: :destroy
  accepts_nested_attributes_for :options, allow_destroy: true
  has_many :user_answers, dependent: :destroy
  validate :option_validation
  def option_validation 
    options = Option.where(question_id: self.id)
    if options.count < 4 
      return true
    elsif options.count == 4 
      if Option.where(question_id: self.id, is_correct_answer: "true").count == 1
        return true
      end
    else
      errors.add(:option, "Error")
    end   
  end
end
