class Order < ApplicationRecord
  has_secure_token
  enum status:         %i(pending confirmed completed cancelled)
  enum goods_status:   %i(pending shipped arrived collected returned), _prefix: :goods
  enum payment_status: %i(pending completed refunded),                 _prefix: :payment

  belongs_to :shop
  belongs_to :customer, optional: true
  has_many :items, class_name: "OrderItem"
  has_one :info, class_name: "OrderInfo"

  default_scope { includes(:info) }
  accepts_nested_attributes_for :info

  validates :status,         inclusion: statuses.keys
  validates :goods_status,   inclusion: goods_statuses.keys
  validates :payment_status, inclusion: payment_statuses.keys

  delegate :name, :phone, :address, :email, to: :info, prefix: true
  delegate :shipping_info, to: :info

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

  def set_payment_data!(data)
    self.update(data)
  end

  def pay!
    self.payment_completed! unless payment_completed?
  end

  def is_paid?
    payment_status == "completed"
  end

end
