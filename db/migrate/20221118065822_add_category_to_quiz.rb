class AddCategoryToQuiz < ActiveRecord::Migration[6.1]
  def change
    add_reference :quizzes, :category, foreign_key: true
  end
end
