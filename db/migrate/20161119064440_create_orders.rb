class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.belongs_to :shop
      t.belongs_to :customer
      t.decimal    :total_price, precision: 8, scale: 2, default: 0
      t.integer    :state_cd, default: 0
      t.boolean    :is_paid, default: false
      t.string     :payment_method, default: ""
      t.string     :token
      t.index      :token, unique: true

      t.timestamps
    end
  end
end
