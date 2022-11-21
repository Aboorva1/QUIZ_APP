class RemoveAnswerFromOption < ActiveRecord::Migration[6.1]
  def change
    remove_column :options, :answer, :string
  end
end
