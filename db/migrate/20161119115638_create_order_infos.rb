class CreateOrderInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :order_infos do |t|
      t.belongs_to :order
      t.string     :name,    default: ""
      t.integer    :phone
      t.string     :address, default: ""
      t.string     :email,   default: ""

      t.timestamps
    end
  end
end
