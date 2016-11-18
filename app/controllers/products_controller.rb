class ProductsController < ApplicationController

  def index
    @shop = Shop.find(params[:shop_id])
    @products = @shop.products
  end

  def show
  end

end
