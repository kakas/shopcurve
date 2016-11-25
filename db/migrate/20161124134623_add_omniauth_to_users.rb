class AddOmniauthToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column   :users, :provider, :string
    add_column   :users, :uid, :string
    add_index    :users, :uid
    remove_index :users, :email
    add_index    :users, :email
    add_column   :users, :name, :string
  end
end
