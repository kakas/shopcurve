class CartItem < ApplicationRecord
  belongs_to :cart, counter_cache: true
  belongs_to :product

  delegate :name, to: :product
  delegate :price, to: :product
  delegate :stock, to: :product

  default_scope { includes(:product) }

  validates_numericality_of :quantity, less_than_or_equal_to: :stock
  validates_numericality_of :quantity, greater_than_or_equal_to: 1

  after_create :decrese_stock_by_one
  before_update :adjust_stock
  before_destroy :restore_stock

  private

  def decrese_stock_by_one
    product.update(stock: stock - 1)
  end

  def adjust_stock
    product.update(stock: stock + quantity_was - quantity)
  end

  def restore_stock
    product.update(stock: stock + quantity)
  end

end
