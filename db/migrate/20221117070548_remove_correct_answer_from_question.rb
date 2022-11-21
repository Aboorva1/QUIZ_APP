class RemoveCorrectAnswerFromQuestion < ActiveRecord::Migration[6.1]
  def change
    remove_column :questions, :correct_answer, :string
  end
end
