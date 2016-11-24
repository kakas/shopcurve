class CartsController < BuyerController

  def show
  end

  def update
    if current_cart.update(cart_params)
      redirect_to cart_path
    else
      render :show
    end
  end

  private

  def cart_params
    params.require(:cart).permit(cart_items_attributes: [:id, :quantity])
  end

end
