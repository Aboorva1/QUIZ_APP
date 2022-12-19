class AddColumnToUserQuiz < ActiveRecord::Migration[6.1]
  def change
    add_column :user_quizzes, :category_id, :integer
    add_column :user_quizzes, :answers_count, :integer
  end
end
