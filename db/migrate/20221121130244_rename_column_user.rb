class RenameColumnUser < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :isadmin, :is_admin
  end
end
