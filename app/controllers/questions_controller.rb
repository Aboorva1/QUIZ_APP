class QuestionsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:new, :show, :create, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
    
  end

  def new
    @question = Question.new 
  end

  def edit
    add_breadcrumb(@quiz.sub_category_name, quizzes_path(sub_category_name: @quiz.sub_category_name))
    add_breadcrumb(@quiz.title,@quiz)
  end

  def update
    correct_index = params[:question][:options_attributes][:is_correct_answer]
    correct_answer = @question.options[correct_index.to_i]
    correct_answer.update(:is_correct_answer => true)
    falsify_others = Option.where("question_id = ? AND id NOT IN (?)", @question.id, correct_answer.id).update_all(:is_correct_answer => false)
    if (@question.update(question_params))
      redirect_to @quiz
    else
      render :edit
    end
  end

  def create      
    @quiz = Quiz.find(params[:quiz_id])
    correct_index = params[:question][:options_attributes][:is_correct_answer]
    if correct_index.present?
      @question = Question.create(question_params)
      correct_answer = @question.options[correct_index.to_i]
      correct_answer.update(:is_correct_answer => true)
      if !@question.save
        flash[:error] = "Fill all questions and options" 
      end
    else  
      flash[:error] = "Fill all questions, options and select correct key"
    end 
    redirect_to @quiz
  end

  def destroy
    @question.destroy
    if @question.destroyed?
      flash[:success] = 'Question is destroyed'
    else
      flash[:error] = 'Failed to destroy'
    end
    redirect_to quiz_path(@quiz)
  end
  
  private

  def set_question
    @quiz = Quiz.find(params[:quiz_id])
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body, :quiz_id, options_attributes: [:id, :choice, :is_correct_answer])
  end
end

