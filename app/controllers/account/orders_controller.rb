class Account::OrdersController < BuyerController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.where(shop_id: current_shop.id).order("created_at desc")
  end

end
