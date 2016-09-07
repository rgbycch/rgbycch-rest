class FixNameColumn < ActiveRecord::Migration[4.2]
  def change
    rename_column :clubs, :name, :title
  end
end
