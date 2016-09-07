class AddPlayerPositionToRoles < ActiveRecord::Migration[4.2]
  def change
    add_column :roles, :position_number, :integer
  end
end
