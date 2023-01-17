class RenameCategoryNameInQuiz < ActiveRecord::Migration[6.1]
  def change
    rename_column :quizzes, :category_name, :sub_category_name
  end
end
