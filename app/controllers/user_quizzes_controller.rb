class UserQuizzesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_page, only: [:show]
  before_action :check_admin

  def index
    @user_answers = UserAnswer.last(session[:answers_count])
  end

  def show
    questions_per_page = 1
    if @page == 0
      session[:start_time] = Time.now
      session[:quiz_id] = params[:id]
    end
    @quiz = Quiz.find(params[:id])
    @question_count = Question.where(quiz_id: params[:id]).count
    @question = Question.where(quiz_id: params[:id]).offset(questions_per_page * @page).limit(questions_per_page)
  end

  def save_answer
    if (params[:auto_save] == "false")
      if (params[:answers].present?)
        quiz_id = save_user_answer(params[:answers])
        page = params[:page].to_i + 1
        redirect_to user_quiz_path(page: page, id: quiz_id)
      else
        flash[:error] = "Please select one option"
        redirect_back(fallback_location: root_path)
      end
    else
      if (params[:answers].present?)
        quiz_id = save_user_answer(params[:answers])
        answers_count = (params[:page].to_i) + 1
        save_user_quiz(answers_count)
      else
        answers_count = (params[:page].to_i)
        save_user_quiz(answers_count)
      end
    end
  end


  def submit_quiz
    if (params[:auto_save] == "false")
      if (params[:answers].present?)
        quiz_id = save_user_answer(params[:answers])
        answers_count = Question.where(quiz_id: quiz_id).count
        save_user_quiz(answers_count)
      else
        flash[:error] = "Please select one option"
        redirect_back(fallback_location: root_path)
      end
    else
      if params[:answers].present? 
        quiz_id = save_user_answer(params[:answers])
        answers_count = Question.where(quiz_id: quiz_id).count
        save_user_quiz(answers_count)
      else
        answers_count = (params[:page].to_i)
      end
    end
  end


  def my_quiz
    @user_quizzes = UserQuiz.where(user_id: current_user.id) 
  end 
  

  private

  def save_user_answer(answer)
    score = 0
    end_time = Time.now
    quiz_id = Question.find_by(id: answer.keys.first).quiz_id
    answer.to_enum.to_h.each do |key, value|
      @user_answer = UserAnswer.new(
        quiz_id: quiz_id,
        user_id: current_user.id,
        question_id: key,
        user_correct_answer: Option.find_by(choice: value, question_id: key).is_correct_answer,
        option_id: Option.find_by(choice: value).id,
      )

    end
    if @user_answer.user_correct_answer == 't'
      score += 1
    end
    @user_answer.score = score
    @user_answer.save
    return quiz_id
  end

  def save_user_quiz(answers_count)
    session[:answers_count] = answers_count
    end_time = Time.now
    questions_count = Question.where(quiz_id: session[:quiz_id]).count
    question_scores = []
    UserAnswer.where(quiz_id: session[:quiz_id]).last(answers_count).each do |user_answer|
      question_scores << user_answer.score
    end
    duration = (end_time - (session[:start_time].to_datetime)).to_i
    @user_quiz = UserQuiz.new(
      quiz_id: session[:quiz_id],
      user_id: current_user.id,
      score: (question_scores.sum) * 10,
      start_time: session[:start_time],
      end_time: end_time,
      quiz_time: duration
    )
    @user_quiz.save!
    redirect_to result_user_quizzes_path(:id => session[:quiz_id], :quiz_score => @user_quiz.score, :questions_count => questions_count, :answers_count =>answers_count)
  end

  def set_page
    @page = (params[:page] || 0).to_i
  end

  def check_admin
    if current_user.is_admin?
      redirect_back(fallback_location: root_path)
    end
  end

end
