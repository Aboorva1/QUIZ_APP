class SubCategoriesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_sub_category, only: [:edit, :update, :destroy]
  before_action :check_user, only: [:new, :create, :edit, :update, :destroy]

  def new
    @sub_category = SubCategory.new
  end

  def create
    @sub_category = SubCategory.new(sub_category_params)
    respond_to do |format|
      if @sub_category.save
        format.html { redirect_to quizzes_path, notice: "Sub-Category created!" }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    if @sub_category.update(sub_category_params)
      redirect_to quizzes_path
    else
      render :edit
    end
  end

  def edit

  end

  def destroy
    @sub_category.destroy
    if @sub_category.destroyed?
      flash[:success] = 'Category deleted'
    else
      flash[:error] = 'Failed to destroy'
    end
    redirect_to root_path
  end

  def show
    @sub_category = SubCategory.find(params[:id])
    add_breadcrumb(@sub_category.title)
    users = UserQuiz.where(sub_category_id: @sub_category.id).distinct.pluck(:user_id)
    @average = []
    users.each do |user|
      user_quizzes = UserQuiz.order('quiz_id, created_at DESC').select('distinct on (quiz_id) *').where(sub_category_id: @sub_category.id, user_id: user)
      @average << {
        user: user,
        average: (user_quizzes.sum('score')/user_quizzes.count(:all)).to_i,
        count: user_quizzes.count(:all)
      }
    end
    @average.sort_by! {|average| [average[:count], average[:average]] }.reverse!
  end

  private

  def set_sub_category
    @sub_category = SubCategory.find(params[:id])
  end

  def sub_category_params
    params.require(:sub_category).permit(:title, :category_id)
  end
end
