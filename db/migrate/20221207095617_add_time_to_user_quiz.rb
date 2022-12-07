class AddTimeToUserQuiz < ActiveRecord::Migration[6.1]
  def change
    add_column :user_quizzes, :start_time, :datetime
    add_column :user_quizzes, :end_time, :datetime
  end
end
