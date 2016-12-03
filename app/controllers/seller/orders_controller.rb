class Seller::OrdersController < SellerController
  before_action :shop_required!
  before_action :set_order, only: [:edit, :update]
  layout "seller"

  def index
    @orders = current_shop.orders.page params[:page]
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
    if current_shop.blank?
      redirect_to seller_shop_path
    end
  end

  def set_order
    @order = current_shop.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status, :payment_status, :goods_status)
  end

end
