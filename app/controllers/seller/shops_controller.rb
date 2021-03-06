class Seller::ShopsController < SellerController

  add_breadcrumb "Shop Info", :seller_shop_path

  def show
    if current_shop
      @shop = current_shop
    else
      @shop = Shop.create(title: "enter your shop name", email: current_user.email)
      current_user.update(shop_id: @shop.id)
    end
  end

  def update
    if current_shop.update(shop_params)
      flash[:success] = "更新成功"
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:title, :email, :subdomain, :merchant_id, :hash_key, :hash_iv)
  end

end
