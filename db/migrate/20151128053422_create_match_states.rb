class CreateMatchStates < ActiveRecord::Migration[4.2]
  def change
    create_table :match_states do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
