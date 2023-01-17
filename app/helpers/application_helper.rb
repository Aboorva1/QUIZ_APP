module ApplicationHelper
    def get_stored_answers(user_quiz_id, question_id)
      if UserAnswer.where(user_quiz_id: user_quiz_id, question_id: question_id).exists?
        user_answer = UserAnswer.find_by(user_quiz_id: user_quiz_id, question_id: question_id)
        return user_answer.option.choice
      end
    end
end
