class OptionsController < ApplicationController

  before_action :set_option, only: [:edit, :update, :destroy]  
  before_action :falsify_all_others, only:[:edit, :update]

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
    if @option.destroyed?
      flash[:success] = 'Option is destroyed'
    else
      flash[:error] = 'Failed to destroy'
    end
    redirect_to quiz_question_path(@quiz, @question)
  end


  private

  def set_option
    @quiz = Quiz.find(params[:quiz_id])
    @question = Question.find(params[:question_id])
    @option = Option.find(params[:id])
  end

  def falsify_all_others
    falsify_others = Option.where("question_id = ? AND id NOT IN (?)" , params[:question_id], @option.id).update_all(:boolean_correct_answer => false)
    @option.boolean_correct_answer = true if params[:boolean_correct_answer]
  end

  def option_params
    params.require(:option).permit(:option, :boolean_correct_answer)
  end
end



