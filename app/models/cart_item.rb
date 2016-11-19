class CartItem < ApplicationRecord
  belongs_to :cart, counter_cache: true
  belongs_to :product

  delegate :name, to: :product
  delegate :price, to: :product
  delegate :stock, to: :product

  validates_numericality_of :quantity, less_than_or_equal_to: :stock
end
