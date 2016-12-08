class CartsController < BuyerController

  def show
  end

  def update
    if current_cart.update(cart_params)
      flash[:success] = "成功更新購物車"
    end
  end

  private

  def cart_params
    params.require(:cart).permit(cart_items_attributes: [:id, :quantity])
  end

end
