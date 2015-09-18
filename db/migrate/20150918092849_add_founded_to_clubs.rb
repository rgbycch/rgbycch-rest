class AddFoundedToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :founded, :datetime
  end
end
