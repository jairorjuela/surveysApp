class AddAuthenticationTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :authentication_token, :string, :limit=> 30, unique: true
  end
end
