class CreateMatchDayTeams < ActiveRecord::Migration[4.2]
  def change
    create_table :match_day_teams do |t|
      t.string :title
      t.string :url

      t.timestamps null: false
    end
  end
end
