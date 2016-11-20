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

  def update
    @shop = current_user.shop

    if @shop.update(shop_params)
      redirect_to seller_shop_path
    else
      render :show
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:title, :email, :merchant_id, :hash_key, :hash_iv)
  end

end
