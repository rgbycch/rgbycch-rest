class AddTeamToUsers < ActiveRecord::Migration
  def change
    add_reference :teams, :club, index: true
    add_foreign_key :teams, :clubs
  end
end
