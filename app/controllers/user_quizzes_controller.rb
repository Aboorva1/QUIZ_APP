class UserQuizzesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_page, :set_quiz, only: [:show]
  before_action :check_admin

  def index
    @questions = Question.where(quiz_id: session[:quiz_id]) 
    @user_answers = UserAnswer.last(session[:answers_count])
  end

  def start
    @user_quiz = UserQuiz.new(
      quiz_id: params[:id],
      user_id: current_user.id,
      start_time: Time.now
    )
    session[:quiz_id] = params[:id]
    session[:user_quiz_id] = @user_quiz.id
    redirect_to user_quiz_path(id: params[:id])
  end

  
  def show
    
    add_breadcrumb(@quiz.sub_category_name)
    add_breadcrumb(@quiz.title)
    questions_per_page = 1    
    @quiz = Quiz.find(params[:id])
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

  def result
    add_breadcrumb("Result")
    @user_quiz = UserQuiz.last
  end

  def my_quiz
    add_breadcrumb("My Quizzes")
    @user_quizzes = UserQuiz.where(user_id: current_user.id).order("created_at DESC")
  end 

  private

  def save_user_answer(answer)
    end_time = Time.now
    quiz_id = Question.find_by(id: answer.keys.first).quiz_id
    score = 0

    if UserAnswer.where(user_quiz_id: session[:user_quiz_id], question_id: answer.keys.first.to_i).exists?
      @user_answer = UserAnswer.where(user_quiz_id: session[:user_quiz_id], question_id: answer.keys.first.to_i)
      answer.to_enum.to_h.each do |key, value|
        @user_answer.update(option_id: Option.find_by(choice: value).id, 
        user_correct_answer: Option.find_by(choice: value, question_id: key).is_correct_answer)
      end
      if @user_answer.first.user_correct_answer == 't'
        @user_answer.update(score: score+1)
      end  
    else
      answer.to_enum.to_h.each do |key, value|
        @user_answer = UserAnswer.new(
          quiz_id: quiz_id,
          user_id: current_user.id,
          question_id: key,
          user_quiz_id: session[:user_quiz_id],
          user_correct_answer: Option.find_by(choice: value, question_id: key).is_correct_answer,
          option_id: Option.find_by(choice: value).id
        )
      end

      if @user_answer.user_correct_answer == 't'
        score += 1
      end
      @user_answer.score = score
      @user_answer.save
    end
    
    return quiz_id
  end

  def save_user_quiz(answers_count)
    session[:answers_count] = answers_count
    @user_quiz = UserQuiz.last
    end_time = Time.now
    sub_category_id = Quiz.find_by(id: @user_quiz.quiz_id).sub_category.id
    category_id = Quiz.find_by(id: @user_quiz.quiz_id).sub_category.category.id
    question_scores = []
    UserAnswer.where(quiz_id: @user_quiz.quiz_id).last(answers_count).each do |user_answer|
      question_scores << user_answer.score
    end
    duration = (end_time - (@user_quiz.start_time.to_datetime)).to_i
    @user_quiz.update(
      score: (question_scores.sum) * 10,
      end_time: end_time,
      quiz_time: duration,
      category_id: category_id,
      sub_category_id: sub_category_id,
      answers_count: answers_count
    )
    @user_quiz.save!
    redirect_to result_user_quizzes_path
  end

  def set_page
    @page = (params[:page] || 0).to_i
  end

  def check_admin
    if current_user.is_admin?
      redirect_back(fallback_location: root_path)
    end
  end

  def set_quiz
    @quiz = Quiz.find(params[:id])
  end
end
