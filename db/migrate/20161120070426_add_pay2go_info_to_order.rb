class AddPay2goInfoToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :bank_code,   :string, default: ""
    add_column :orders, :code_no,     :string, default: ""
    add_column :orders, :expire_time, :string, default: ""
  end
end
