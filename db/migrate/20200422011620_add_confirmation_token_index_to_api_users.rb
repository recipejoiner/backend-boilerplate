class AddConfirmationTokenIndexToApiUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :api_users, :confirmation_token
  end
end
