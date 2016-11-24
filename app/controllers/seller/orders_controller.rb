class Seller::OrdersController < SellerController
  before_action :shop_required!
  before_action :set_shop
  before_action :set_order, only: [:edit, :update]
  layout "seller"

  def index
    @orders = @shop.orders
  end

  def edit
  end

  def update
    if @order.update(order_params)
      redirect_to seller_orders_path
    else
      render :edit
    end
  end

  private

  def shop_required!
    if current_user.shop.blank?
      redirect_to seller_shop_path
    end
  end

  def set_shop
    @shop = current_user.shop
  end

  def set_order
    @order = @shop.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status, :payment_status, :goods_status)
  end

end
