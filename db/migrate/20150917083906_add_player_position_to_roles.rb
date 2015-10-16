class AddPlayerPositionToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :position_number, :integer
  end
end
