class QuizzesController < ApplicationController

  before_action :authenticate_user!
  before_action :check_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]

  def index
    if(params.has_key?(:sub_category_name))
      @quizzes = Quiz.where(sub_category_name: params[:sub_category_name]).paginate(page: params[:page], per_page: 20).order("created_at desc")
    else
      @quizzes = Quiz.all.paginate(page: params[:page], per_page: 20).order("created_at desc")
    end
    @categories = Category.all
  end

  def show
    @options = []
    @question = @quiz.questions.build
    4.times {@options << @question.options.build}
  end

  def new
    @quiz = Quiz.new
  end
  
  def create
    @quiz = Quiz.new(quiz_params)
    set_sub_category_name
    respond_to do |format|
      if @quiz.save
        format.html { redirect_to @quiz, notice: "Quiz created!" }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit
    
  end

  def update
    set_sub_category_name
    if @quiz.update(quiz_params)
      redirect_to @quiz
    else
      render :edit
    end
  end

  def destroy
    @quiz.destroy
    if @quiz.destroyed?
      flash[:success] = 'Quiz is destroyed'
    else
      flash[:error] = 'Failed to destroy'
    end
    redirect_to root_path
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:id])
  end

  def quiz_params
    params.require(:quiz).permit(:sub_category_id, :title, :minutes, :quiz_image)
  end

  def set_sub_category_name
    @quiz.sub_category_name = SubCategory.find_by(id: quiz_params[:sub_category_id]).title
  end
end


