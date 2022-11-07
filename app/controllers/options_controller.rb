class OptionsController < ApplicationController

  before_action :set_option, only: [:edit, :update, :destroy]  

  def index
    @options = Option.all
  end

  def new
    @quiz = Quiz.find(params[:quiz_id])
    @question = Question.find(params[:question_id])
    @option = @question.options.new
  end
  
  def create
    @quiz = Quiz.find(params[:quiz_id])
    @question = Question.find(params[:question_id])
    @option = @question.options.create(option_params)
    
    if @option.save
        redirect_to quiz_question_path(@quiz, @question)
    else
        render :new
    end
  end

  def edit
   
  end

  def update
    if (@option.update(option_params))
      redirect_to quiz_question_path(@quiz, @question)
   else
     render :edit
    end
  end

  def destroy
    @option.destroy
    redirect_to quiz_question_path(@quiz, @question)
  end

  private

  def set_option
    @quiz = Quiz.find(params[:quiz_id])
    @question = Question.find(params[:question_id])
    @option = Option.find(params[:id])
  end

  def option_params
    params.require(:option).permit(:option1, :correct_key, :question_id)
  end
end



