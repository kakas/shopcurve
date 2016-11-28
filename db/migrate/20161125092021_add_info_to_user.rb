class AddInfoToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :address,      :string, default: ""
    add_column :users, :phone,        :integer
    add_column :users, :orders_count, :integer, default: 0
  end
end
