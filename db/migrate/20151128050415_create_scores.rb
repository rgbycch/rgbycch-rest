class CreateScores < ActiveRecord::Migration[4.2]
  def change
    create_table :scores do |t|
      t.integer :home_score
      t.integer :away_score

      t.timestamps null: false
    end
  end
end
