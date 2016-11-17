class Seller::ShopsController < SellerController

  def show
    @shop = current_user.shop || Shop.new
  end

  def create
    @shop = Shop.new(shop_params)

    if @shop.save
      current_user.update(shop_id: @shop.id)
      redirect_to seller_shop_path
    else
      render :show
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:title, :email)
  end

end
