class AddScoreToUserAnswer < ActiveRecord::Migration[6.1]
  def change
    add_column :user_answers, :score, :integer
  end
end
