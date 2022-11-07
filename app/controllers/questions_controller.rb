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
        @question = @quiz.questions.create(question_params)
        redirect_to quiz_path(@quiz)
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
      params.require(:question).permit(:body)
    end
end

