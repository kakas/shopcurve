class BuyerController < ApplicationController
  helper_method :current_shop, :current_cart

  protected

  def current_cart
    if session[:current_shop_id] == params[:shop_id].to_i
      @current_cart ||= find_cart
    else
      @current_cart = find_cart
    end
  end

  def current_shop
    @shop ||= Shop.find(params[:shop_id])
  end

  private

  def find_cart
    cart = current_shop.carts.find_by(id: session[:cart_ids].to_a)

    if !cart
      cart = current_shop.carts.create
      session[:cart_ids] = [] if session[:cart_ids].nil?
      session[:cart_ids] << cart.id unless session[:cart_ids].include?(cart.id)
    end
    session[:current_shop_id] = current_shop.id
    cart
  end

end
