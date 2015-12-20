class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :title
      t.string :url
      t.float :latitude
      t.float :longitude
      t.integer :capacity

      t.timestamps null: false
    end
  end
end
