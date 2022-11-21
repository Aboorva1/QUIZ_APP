class DropTableEvents < ActiveRecord::Migration[6.1]
  def change
    drop_table :events
  end
end
