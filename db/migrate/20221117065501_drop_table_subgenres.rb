class DropTableSubgenres < ActiveRecord::Migration[6.1]
  def change
    drop_table :subgenres
  end
end
