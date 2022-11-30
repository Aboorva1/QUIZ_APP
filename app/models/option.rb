class Option < ApplicationRecord
  belongs_to :question
  has_many :user_answers, dependent: :destroy

  validates :choice, presence: true

  validate :options_count, on: :create
  validate :correct_answer_count, on: :create

  private 

  def options_count   
    options = Option.where(question_id: question_id)
    if options.count >= 4
      errors.add(:base, "Question should have exactly 4 options")
    end
  end

  def correct_answer_count

    false_count = true_count = 0
    if self.is_correct_answer == false
      false_count = 1
    elsif self.is_correct_answer == true
      true_count = 1
    end

    wrong_options = Option.where(question_id: question_id, is_correct_answer: "false")
    correct_options = Option.where(question_id: question_id, is_correct_answer: "true")
    
    false_count = wrong_options.count + false_count
    true_count = correct_options.count + true_count

    if (false_count == 4 || true_count > 1)
      errors.add(:base, "Mark one option as true")
    end
  end

end
