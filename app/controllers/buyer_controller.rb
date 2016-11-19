class BuyerController < ApplicationController
  before_action :set_shop
  helper_method :current_cart


  protected

  def current_cart
    if session[:current_shop_id] == params[:shop_id].to_i
      @current_cart ||= find_cart
    else
      @current_cart = find_cart
    end
  end

  private

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def find_cart
    shop = Shop.find(params[:shop_id])
    cart = shop.carts.find_by(id: session[:cart_ids].to_a)

    if !cart
      cart = shop.carts.create
      session[:cart_ids] = [] if session[:cart_ids].nil?
      session[:cart_ids] << cart.id unless session[:cart_ids].include?(cart.id)
    end
    session[:current_shop_id] = shop.id
    cart
  end

end
