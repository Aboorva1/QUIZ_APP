class AnswerController < ApplicationController
  $score = 0 
  def create_answers
      
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
      
      redirect_to answer_result_path
      
  end

  def user_answer_params
    params.require(:answers)
  end
end
