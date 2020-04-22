class AddJtiToApiUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :api_users, :jti, :string, null: false
    add_index :api_users, :jti
  end
end
