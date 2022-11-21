class RemoveColumnAndRenameColumnFromUserAnswer < ActiveRecord::Migration[6.1]
  def change
    remove_column :user_answers, :answer_key, :text
    rename_column :user_answers, :user_key, :user_correct_answer
  end
end
