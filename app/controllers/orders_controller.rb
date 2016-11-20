class OrdersController < BuyerController
  protect_from_forgery except: [:pay2go_return, :pay2go_notify]

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
    @order = Order.find_by_token(params[:token])
  end

  def pay2go_return
    @order = Order.find_by_token(params[:token])
    service = Pay2goService.new(current_shop, @order, params[:JSONData])

    if service.success?
      if !@order.is_paid?
        @order.set_payment_method!(service.payment_method)
        @order.pay!
      end
      redirect_to shop_order_path(current_shop, @order.token)
    else
      render text: service.message
    end
  end

  def pay2go_notify
    @order = Order.find_by_token(params[:token])
    service = Pay2goService.new(current_shop, @order, params[:JSONData])

    if service.success?
      if !@order.is_paid?
        @order.set_payment_method!(service.payment_method)
        @order.pay!
      end
    else
      puts service.message
    end
    render nothing: true, status: 200
  end

  private

  def order_params
    params.require(:order).permit(info_attributes: [:name, :phone, :address, :email])
  end

end
