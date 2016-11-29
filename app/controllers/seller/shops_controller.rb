class Seller::ShopsController < SellerController

  def show
    if current_user.shop
      @shop = current_user.shop
    else
      @shop = Shop.create(title: "enter your shop name", email: current_user.email)
      current_user.update(shop_id: @shop.id)
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
    params.require(:shop).permit(:title, :email, :subdomain, :merchant_id, :hash_key, :hash_iv)
  end

end
