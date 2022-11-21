class CategoriesController < ApplicationController
  
  before_action :set_category, only: [:edit, :update, :destroy]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to quizzes_path, notice: "Category created!" }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    if @category.update(category_params)
      redirect_to quizzes_path
    else
      render :edit
    end
  end

  def edit

  end

  def destroy
    @category.destroy
    if @category.destroyed?
      flash[:success] = 'Category deleted'
    else
      flash[:error] = 'Failed to destroy'
    end
    redirect_to root_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title)
  end
end
