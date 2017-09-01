class AddRoleToUsers < ActiveRecord::Migration[5.1.3]
  def change
    add_column :users, :role, :string
  end
end
