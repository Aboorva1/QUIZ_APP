class AnswerController < ApplicationController
  
  $score = 0 
  $name = ""

  def index
    
  end


  def create_answers
      if params[:answers].present?
      $score = 0 
      params[:answers].to_enum.to_h.each do |key, value|

      @user_answer = UserAnswer.new
      @user_answer.quiz_id = params[:quiz_id]
      @user_answer.user_id = current_user.id
      @user_answer.question_id = key
      @user_answer.user_key = Option.find_by(option1: value).correct_key
      @user_answer.option_id = Option.find_by(option1: value).id
      if @user_answer.user_key == 't'
        $score += 1 
      end
      @user_answer.save
      
      end
      @user_quiz = UserQuiz.new
      @user_quiz.quiz_id = params[:quiz_id]
      @user_quiz.user_id = current_user.id
      @user_quiz.score = $score * 10
      @user_quiz.quiz_name = Quiz.find(params[:quiz_id]).title
      @user_quiz.name = current_user.name
      @user_quiz.save
      redirect_to answer_result_path
  else
    redirect_back(fallback_location: root_path)
  end
  end


  def myquiz
    #@user_quizzes = UserQuiz.search(params[:search])
    @user_quizzes = UserQuiz.where(user_id: current_user.id).search(params[:search])
   
  end

  def user_answer_params
    params.require(:answers, :search)
  end
end
