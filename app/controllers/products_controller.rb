class ProductsController < BuyerController

  def index
    @products = current_shop.products.where("stock > 0")
  end

  def show
    @product = current_shop.products.find(params[:id])
    @related_products = current_shop.products.sample(4)
  rescue
    flash[:error] = "此商品不存在"
    redirect_to products_path
  end

end
