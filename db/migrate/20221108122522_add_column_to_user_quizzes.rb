class AddColumnToUserQuizzes < ActiveRecord::Migration[6.1]
  def change
    add_column :user_quizzes, :name, :string
  end
end
