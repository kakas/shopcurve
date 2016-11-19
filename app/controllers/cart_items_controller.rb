class CartItemsController < BuyerController

  def create
    @product = @shop.products.find(params[:product_id])
    if !current_cart.items.include?(@product)
      current_cart.items << @product
    end

    redirect_to shop_products_path(@shop)
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to shop_cart_path(@shop)
  end

end
