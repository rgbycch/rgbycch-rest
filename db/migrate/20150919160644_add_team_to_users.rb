class AddTeamToUsers < ActiveRecord::Migration[4.2]
  def change
    add_reference :teams, :club, index: true
    add_foreign_key :teams, :clubs
  end
end
