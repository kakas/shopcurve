class Seller::OrdersController < SellerController
  before_action :shop_required!
  before_action :set_order, only: [:edit, :update]
  layout "seller"

  add_breadcrumb "Orders", :seller_orders_path

  def index
    @orders = current_shop.orders.page params[:page]
  end

  def edit
    add_breadcrumb "Edit Order", edit_seller_order_path(@order)
  end

  def update
    if @order.update(order_params)
      flash[:success] = "訂單#{@order.token}更新成功"
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
