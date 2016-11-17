class AddShopIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :users, :shop
  end
end
