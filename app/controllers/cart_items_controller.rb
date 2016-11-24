class CartItemsController < BuyerController

  def create
    @product = current_shop.products.find(params[:product_id])
    if !current_cart.items.include?(@product) && @product.stock > 0
      current_cart.items << @product
    end

    redirect_to products_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path
  end

end
