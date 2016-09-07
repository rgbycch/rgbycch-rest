class AddAuthenticationTokenToUsers < ActiveRecord::Migration[4.2]
  def up
    add_column :users, :auth_token, :string, default: ""
    add_index :users, :auth_token, unique: true
  end

  def down
    remove_column :users, :auth_token
    remove_index :users, :auth_token
  end
end
