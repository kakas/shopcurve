class ProductsController < BuyerController

  def index
    @products = current_shop.products.where("stock > 0")
  end

  def show
  end

end
