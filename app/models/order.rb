class Order < ApplicationRecord
  has_secure_token
  belongs_to :shop
  belongs_to :customer
  has_many :items, class_name: "OrderItem"
  has_one :info, class_name: "OrderInfo"

  accepts_nested_attributes_for :info

  def build_item_cache_from(cart)
    cart.cart_items.each do |cart_item|
      item          = items.build
      item.name     = cart_item.name
      item.price    = cart_item.price
      item.quantity = cart_item.quantity
    end
    self.save
  end

  def calculate_total_price!(cart)
    self.update(total_price: cart.total_price)
  end
end
