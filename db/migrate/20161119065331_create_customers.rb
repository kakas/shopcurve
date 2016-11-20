class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.belongs_to :shop
      t.string     :name,         default: ""
      t.integer    :phone,        index:   true
      t.string     :address,      default: ""
      t.string     :email,        default: ""
      t.integer    :orders_count, default: 0

      t.timestamps
    end
  end
end
