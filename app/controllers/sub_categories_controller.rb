class SubCategoriesController < ApplicationController
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

  private

  def set_sub_category
    @sub_category = SubCategory.find(params[:id])
  end

  def sub_category_params
    params.require(:sub_category).permit(:title, :category_id)
  end
end
