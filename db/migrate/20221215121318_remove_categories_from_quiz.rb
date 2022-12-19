class RemoveCategoriesFromQuiz < ActiveRecord::Migration[6.1]
  def change
    remove_reference :quizzes, :category, null: false, foreign_key: true
  end
end
