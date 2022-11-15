class QuestionsController < ApplicationController

  before_action :set_question, only: [:show, :edit, :update, :destroy]

      def index
        @questions = Question.all
      end

      def show
        @quiz = Quiz.find(params[:quiz_id])
        @question = Question.find(params[:id])
      end
    
      def new
        @question = Question.new 
      end

    
      def edit
        @quiz = Quiz.find(params[:quiz_id])
        @question = Question.find(params[:id])
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
        correct_index = params[:question][:options_attributes][:correct_key]
        if correct_index.present?
          update_correct_answer = @question.options[correct_index.to_i]
          update_correct_answer.update(:correct_key => true)
          if @question.save
            redirect_to @quiz
          else
            flash[:error] = "Fill all questions and options"
            redirect_to @quiz
          end
        else  
            flash[:error] = "Fill all questions, options and select correct key"
            redirect_to @quiz
        end 
      end

      def destroy
        @question.destroy
        redirect_to quiz_path(@quiz)
      end
      
      private

      def set_question
        @quiz = Quiz.find(params[:quiz_id])
        @question = Question.find(params[:id])
      end

    def question_params
      params.require(:question).permit(:body, :quiz_id, options_attributes: [:id, :option1, :correct_key])
    end
end

