class CreatePreferredPositions < ActiveRecord::Migration[4.2]
  def change
    create_table :preferred_positions do |t|
      t.references :player, index: true, foreign_key: true
      t.references :player_position, index: true, foreign_key: true
      t.integer :preference

      t.timestamps null: false
    end
  end
end
