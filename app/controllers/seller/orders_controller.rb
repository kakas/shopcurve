class Seller::OrdersController < SellerController
  before_action :shop_required!
  before_action :set_shop
  layout "seller"

  def index
    @orders = @shop.orders
  end

  def show
    @order = @shop.orders.find(params[:id])
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

end
