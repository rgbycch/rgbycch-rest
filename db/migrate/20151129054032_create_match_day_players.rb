class CreateMatchDayPlayers < ActiveRecord::Migration[4.2]
  def change
    create_table :match_day_players do |t|
      t.references :player, index: true, foreign_key: true
      t.references :player_position, foreign_key: true
      t.integer :rating
      t.integer :points
      t.integer :fouls
      t.integer :turnovers_for
      t.integer :turnovers_against
      t.integer :penalties_won
      t.integer :penalties_conceded
      t.integer :yellow_cards
      t.integer :red_cards
      t.integer :carries
      t.integer :yards_carried
      t.integer :forward_passes
      t.integer :successful_lineout_throws
      t.integer :unsuccessful_lineout_throws
      t.integer :scrums_won
      t.integer :scrums_lost
      t.integer :successful_garryowens
      t.integer :unsuccessful_garryowens
      t.timestamps null: false
    end
  end
end
