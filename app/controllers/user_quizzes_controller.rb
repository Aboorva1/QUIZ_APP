class UserQuizzesController < ApplicationController

  def user_quiz_page
    questions_count = Question.where(quiz_id: params[:quiz_id]).count 
    if params[:answers].present? && questions_count == params[:answers].to_enum.to_h.count
      score = 0 
      params[:answers].to_enum.to_h.each do |key, value|
        @user_answer = UserAnswer.new(
          quiz_id: params[:quiz_id],
          user_id: current_user.id,
          question_id: key,
          user_correct_answer: Option.find_by(choice: value).is_correct_answer,
          option_id: Option.find_by(choice: value).id
        )
        if @user_answer.user_correct_answer == 't'
          score += 1 
        end
        @user_answer.save
      end
      @user_quiz = UserQuiz.new(
        quiz_id: params[:quiz_id],
        user_id: current_user.id,
        score: score * 10
      )
      @user_quiz.save
      redirect_to result_user_quizzes_path(:id => params[:quiz_id], :score => @user_quiz.score, :questions_count => questions_count)
    else
      flash[:error] = "Answer all questions"
      redirect_back(fallback_location: root_path)
    end
  end
        
  def my_quiz
    @user_quizzes = UserQuiz.where(user_id: current_user.id) 
  end   
end
