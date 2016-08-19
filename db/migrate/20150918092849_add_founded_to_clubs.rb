class AddFoundedToClubs < ActiveRecord::Migration[4.2]
  def change
    add_column :clubs, :founded, :datetime
  end
end
