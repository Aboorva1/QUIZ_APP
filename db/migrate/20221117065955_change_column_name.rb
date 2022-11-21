class ChangeColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :options, :option1, :option
    rename_column :options, :correct_key, :boolean_correct_answer
  end
end
