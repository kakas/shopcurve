class Seller::ProductsController < ApplicationController
  before_action :set_shop
  layout "seller"

  def index
    @products = Product.all
  end

  private

  def set_shop
    @shop = Shop.first
  end

end
