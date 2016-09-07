class CreateClubs < ActiveRecord::Migration[4.2]
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :url, default: ""

      t.timestamps null: false
    end
  end
end
