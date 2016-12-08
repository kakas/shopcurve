class CartItemsController < BuyerController

  def create
    @product = current_shop.products.find(params[:product_id])

    if !current_cart.items.include?(@product) && @product.stock > 0
      flash[:success] = "成功將#{@product.name}加到購物車"
      current_cart.items << @product
    else
      flash[:warning] = "#{@product.name}已在購物車"
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:warning] = "成功將#{@cart_item.name}從購物車刪除"
  end

end
