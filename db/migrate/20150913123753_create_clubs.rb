class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :url, default: ""

      t.timestamps null: false
    end
  end
end
