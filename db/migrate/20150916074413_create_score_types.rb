class CreateScoreTypes < ActiveRecord::Migration
  def change
    create_table :score_types do |t|
      t.string :title
      t.string :url
      t.integer :points

      t.timestamps null: false
    end
  end
end
