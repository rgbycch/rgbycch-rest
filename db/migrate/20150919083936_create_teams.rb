class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
