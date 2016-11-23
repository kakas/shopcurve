class AddStatusToOrder < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :state_cd
    remove_column :orders, :is_paid
    add_column :orders, :status,         :integer, default: 0
    add_column :orders, :goods_status,   :integer, default: 0
    add_column :orders, :payment_status, :integer, default: 0
  end
end
