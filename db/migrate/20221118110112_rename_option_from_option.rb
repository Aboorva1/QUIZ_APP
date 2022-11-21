class RenameOptionFromOption < ActiveRecord::Migration[6.1]
  def change
    rename_column :options, :option, :choice
  end
end
