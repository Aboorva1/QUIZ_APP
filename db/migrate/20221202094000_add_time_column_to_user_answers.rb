class AddTimeColumnToUserAnswers < ActiveRecord::Migration[6.1]
  def change
    add_column :user_answers, :start_time, :datetime
    add_column :user_answers, :end_time, :datetime
  end
end
