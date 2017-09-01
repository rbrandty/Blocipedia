class AddNameToUsers < ActiveRecord::Migration[5.1.3]
  def change
    add_column :users, :name, :string
  end
end
