class CartItemsController < BuyerController

  def create
    @product = current_shop.products.find(params[:product_id])
    if !current_cart.items.include?(@product)
      current_cart.items << @product
    end

    redirect_to shop_products_path(current_shop)
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to shop_cart_path(current_shop)
  end

end
