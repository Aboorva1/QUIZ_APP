class AddUserQuizToUserAnswer < ActiveRecord::Migration[6.1]
  def change
    add_column :user_answers, :user_quiz_id, :integer
  end
end
