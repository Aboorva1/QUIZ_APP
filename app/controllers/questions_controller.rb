class QuestionsController < ApplicationController

  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
    
  end

  def new
    @question = Question.new 
  end

  def edit
    
  end

  def update
    if (@question.update(question_params))
      redirect_to @quiz
    else
      render :edit
    end
  end

  def create      
    @quiz = Quiz.find(params[:quiz_id])
    @question = Question.new(question_params)
    correct_index = params[:question][:options_attributes][:boolean_correct_answer]
    if correct_index.present?
      update_correct_answer = @question.options[correct_index.to_i]
      update_correct_answer.update(:boolean_correct_answer => true)
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
    params.require(:question).permit(:body, :quiz_id, options_attributes: [:id, :option, :boolean_correct_answer])
  end
end

