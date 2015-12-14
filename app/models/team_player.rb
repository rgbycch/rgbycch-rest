class TeamPlayer < ActiveRecord::Base
  self.table_name = "team_player"
  belongs_to :team
  belongs_to :player

  #adds scope to identify captain, vice captain, or other information about a player's role in the team
end
