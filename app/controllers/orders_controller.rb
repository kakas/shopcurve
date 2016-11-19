class OrdersController < BuyerController

  def new
    @order = Order.new
    @order.build_info
  end

  def create
    @customer = current_shop.customers.find_or_create_by(phone: order_params["info_attributes"]["phone"].to_i)
    @order = @customer.orders.build(order_params.merge(shop_id: current_shop.id))

    if @order.save
      @customer.update(order_params["info_attributes"])
      @order.build_item_cache_from(current_cart)
      @order.calculate_total_price!(current_cart)
      current_cart.destroy
      redirect_to shop_order_path(@shop, @order.token)
    else
      render :new
    end
  end

  def show

  end

  private

  def order_params
    params.require(:order).permit(info_attributes: [:name, :phone, :address, :email])
  end


end
