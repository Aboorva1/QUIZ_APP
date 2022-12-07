class AddMinutesToQuizzes < ActiveRecord::Migration[6.1]
  def change
    add_column :quizzes, :minutes, :integer
  end
end
