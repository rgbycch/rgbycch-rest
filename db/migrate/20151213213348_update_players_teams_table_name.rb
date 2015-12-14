class UpdatePlayersTeamsTableName < ActiveRecord::Migration
  def change
    create_table :team_player, :id => false do |t|
      t.integer :team_id
      t.integer :player_id
    end

    add_index :team_player, [:team_id, :player_id]

    execute "INSERT INTO team_player SELECT * FROM players_teams"

    drop_table :players_teams
  end

  def self.down
    drop_table :team_player
  end
end
