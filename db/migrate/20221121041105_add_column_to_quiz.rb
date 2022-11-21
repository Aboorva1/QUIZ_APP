class AddColumnToQuiz < ActiveRecord::Migration[6.1]
  def change
    add_column :quizzes, :category_name, :string
  end
end
