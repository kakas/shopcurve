class AddPay2goInfoToShop < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :merchant_id, :string, default: ""
    add_column :shops, :hash_key,    :string, defualt: ""
    add_column :shops, :hash_iv,     :string, defualt: ""
  end
end
