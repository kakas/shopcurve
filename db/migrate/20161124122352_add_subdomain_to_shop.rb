class AddSubdomainToShop < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :subdomain, :string
  end
end
