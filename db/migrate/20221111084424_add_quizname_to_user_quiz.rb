class AddQuiznameToUserQuiz < ActiveRecord::Migration[6.1]
  def change
    add_column :user_quizzes, :quiz_name, :string
  end
end
