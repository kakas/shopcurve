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
    OrderMailer.delay.notify_order_placed(@order)
    sync_info_to_buyer
  end

  private

  def sync_info_to_buyer
    if !@buyer
      @buyer = @shop.customers.find_or_create_by(phone: @order_info[:phone])
    end
    @buyer.update(@order_info)
    @buyer.orders << @order
  end

end
