class RenameColumnFromOption < ActiveRecord::Migration[6.1]
  def change
    rename_column :options, :boolean_correct_answer, :is_correct_answer
  end
end
