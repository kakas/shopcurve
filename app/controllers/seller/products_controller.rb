class Seller::ProductsController < ApplicationController
  before_action :set_shop, only: [:index, :create]
  layout "seller"

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = @shop.products.build(product_params)

    if @product.save
      redirect_to seller_products_path
    else
      render :new
    end
  end

  private

  def set_shop
    @shop = Shop.first
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock)
  end

end
