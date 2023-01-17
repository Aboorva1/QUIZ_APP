class RemoveTimeFromUserAnswer < ActiveRecord::Migration[6.1]
  def change
    remove_column :user_answers, :start_time, :datetime
    remove_column :user_answers, :end_time, :datetime
  end
end
