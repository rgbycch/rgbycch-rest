class FixNameColumn < ActiveRecord::Migration
  def change
    rename_column :clubs, :name, :title
  end
end
