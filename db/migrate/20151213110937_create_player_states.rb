class CreatePlayerStates < ActiveRecord::Migration[4.2]
  def change
    create_table :player_states do |t|
      t.string :title
      t.string :url

      t.timestamps null: false
    end
  end
end
