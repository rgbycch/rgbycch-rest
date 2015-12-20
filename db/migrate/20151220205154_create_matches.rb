class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :home_match_day_team_id
      t.integer :away_match_day_team_id
      t.datetime :kick_off_date
      t.references :venue, index: true, foreign_key: true
      t.integer :referee_id
      t.integer :match_state_id

      t.timestamps null: false
    end
  end
end
