class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.belongs_to :order
      t.string     :name
      t.decimal    :price, precision: 8, scale: 2
      t.integer    :quantity

      t.timestamps
    end
  end
end
