class UserQuizzesController < ApplicationController
  before_action :set_page, only: [:show, :quiz_user_page]

  def show
    questions_per_page = 1
    @quiz = Quiz.find(params[:id])
    @question_count = Question.where(quiz_id: params[:id]).count
    @question = Question.where(quiz_id: params[:id]).offset(questions_per_page * @page).limit(questions_per_page)
  end

  def quiz_user_page
    if params[:answers].present?
      quiz_id = set_user_answer(params[:answers])
      page = params[:page].to_i + 1
      redirect_to user_quiz_path(page: page, id: quiz_id)
    else
      flash[:error] = "Please select one option"
      redirect_back(fallback_location: root_path)
    end
    
  end

  def submit_quiz
    if params[:answers].present?
      quiz_id = set_user_answer(params[:answers])
      question_scores = []
      questions_count = Question.where(quiz_id: quiz_id).count
      UserAnswer.where(quiz_id: quiz_id).last(questions_count).each do |user_answer|
        question_scores << user_answer.score
      end
      @user_quiz = UserQuiz.new(
        quiz_id: quiz_id,
        user_id: current_user.id,
        score: (question_scores.sum) * 10
      )
      puts @user_quiz.score
      redirect_to result_user_quizzes_path(:id => quiz_id, :quiz_score => @user_quiz.score, :questions_count => questions_count)
    else
      flash[:error] = "Please select one option"
      redirect_back(fallback_location: root_path)
    end
  end

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
  

  private

  def set_user_answer(answer)
    score = 0
    quiz_id = Question.find_by(id: answer.keys.first).quiz_id
    answer.to_enum.to_h.each do |key, value|
      @user_answer = UserAnswer.new(
        quiz_id: quiz_id,
        user_id: current_user.id,
          question_id: key,
          user_correct_answer: Option.find_by(choice: value).is_correct_answer,
          option_id: Option.find_by(choice: value).id
        )
    end
    if @user_answer.user_correct_answer == 't'
      score += 1
    end
    @user_answer.score = score
    @user_answer.save
    return quiz_id
  end

  def set_page
    @page = (params[:page] || 0).to_i
  end
end
