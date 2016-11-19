class Cart < ApplicationRecord
  belongs_to :shop
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product

  accepts_nested_attributes_for :cart_items

  def total_price
    cart_items.inject(0) do |sum, cart_item|
      sum + cart_item.quantity * cart_item.price
    end
  end
end
