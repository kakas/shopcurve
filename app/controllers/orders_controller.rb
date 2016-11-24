class OrdersController < BuyerController
  protect_from_forgery except: [:pay2go_return, :pay2go_customer, :pay2go_notify]
  before_action :set_pay2go_service, only: [:pay2go_return, :pay2go_customer, :pay2go_notify]

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
      OrderMailer.notify_order_placed(current_shop, @order).deliver!

      redirect_to shop_order_path(current_shop, @order.token)
    else
      render :new
    end
  end

  def show
    set_order
  end

  def pay2go_return
    if @service.success?
      @order.set_payment_data!(@service.payment_data)
      @order.pay!
      redirect_to shop_order_path(current_shop, @order.token)
    else
      render text: @service.message
    end
  end

  def pay2go_customer
    @order.set_payment_data!(@service.payment_data) if @service.success?
    redirect_to shop_order_path(current_shop, @order.token)
  end

  def pay2go_notify
    if @service.success?
      @order.pay!
    else
      puts @service.message
    end
    render nothing: true, status: 200
  end

  private

  def set_order
    @order = Order.find_by_token(params[:token])
  end

  def set_pay2go_service
    set_order
    @service = Pay2goService.new(current_shop, @order, params[:JSONData])
  end

  def order_params
    params.require(:order).permit(info_attributes: [:name, :phone, :address, :email])
  end

end
