class CreateMatchStates < ActiveRecord::Migration
  def change
    create_table :match_states do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
