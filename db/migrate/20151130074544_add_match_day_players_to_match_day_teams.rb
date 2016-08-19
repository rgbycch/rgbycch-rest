class AddMatchDayPlayersToMatchDayTeams < ActiveRecord::Migration[4.2]
  def change
    add_reference :match_day_players, :match_day_team, index: true
    add_foreign_key :match_day_players, :match_day_teams
  end
end
