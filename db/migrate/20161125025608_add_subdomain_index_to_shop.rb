class AddSubdomainIndexToShop < ActiveRecord::Migration[5.0]
  def change
    add_index :shops, :subdomain
  end
end
