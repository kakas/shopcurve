class CartsController < BuyerController

  def show
  end

  def update
    if current_cart.update(cart_params)
      redirect_to shop_cart_path(current_shop)
    else
      render :show
    end
  end

  private

  def cart_params
    params.require(:cart).permit(cart_items_attributes: [:id, :quantity])
  end

end
