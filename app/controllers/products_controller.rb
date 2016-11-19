class ProductsController < BuyerController

  def index
    @products = current_shop.products
  end

  def show
  end

end
