class OrdersController < BuyerController
  protect_from_forgery except: [:pay2go_return, :pay2go_customer, :pay2go_notify]
  before_action :set_pay2go_service, only: [:pay2go_return, :pay2go_customer, :pay2go_notify]

  def new
    @order = Order.new
    @order.build_info(current_user&.shipping_info)
  end

  def create
    @order = current_shop.orders.build(order_params)

    if @order.save
      session[:cart_ids].delete(current_cart.id)
      OrderPlacingService.new(current_user, current_cart, @order).place_order!
      session[:order_token] = @order.token if !current_user
      redirect_to order_path(@order.token)
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
      redirect_to order_path(@order.token)
    else
      render text: @service.message
    end
  end

  def pay2go_customer
    @order.set_payment_data!(@service.payment_data) if @service.success?
    redirect_to order_path(@order.token)
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
