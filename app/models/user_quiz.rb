class UserQuiz < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  def self.search(search)
    if search
      user_quiz = UserQuiz.find_by(quiz_name: search)
      if user_quiz
        self.where(id: user_quiz)
      else
        UserQuiz.all
      end
    else
      UserQuiz.all
    end
  end
end
