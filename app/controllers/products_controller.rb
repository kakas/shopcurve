class ProductsController < BuyerController

  def index
    @products = @shop.products
  end

  def show
  end

end
