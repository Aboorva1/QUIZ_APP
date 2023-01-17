class AddQuizTimeToUserQuiz < ActiveRecord::Migration[6.1]
  def change
    add_column :user_quizzes, :quiz_time, :integer
  end
end
