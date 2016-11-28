class OrderPlacingService

  def initialize(user, cart, order)
    @buyer = user
    @cart = cart
    @shop = order.shop
    @order = order
    @order_info = order.shipping_info
  end

  def place_order!
    @order.build_item_cache_from(@cart)
    @order.calculate_total_price!(@cart)
    @cart.destroy
    OrderMailer.notify_order_placed(@order).deliver!
  end

end
