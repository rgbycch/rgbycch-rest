class CreatePlayers < ActiveRecord::Migration[4.2]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :nick_name
      t.datetime :dob
      t.string :email
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
