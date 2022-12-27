class AddSubCategoryToUserQuiz < ActiveRecord::Migration[6.1]
  def change
    add_column :user_quizzes, :sub_category_id, :integer
  end
end
