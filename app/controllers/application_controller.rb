class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_cart

  protected

  def current_cart
    if session[:current_shop_id] == params[:shop_id]
      @current_cart ||= find_cart
    else
      @current_cart = find_cart
    end
  end

  def after_sign_in_path_for(resource)
    seller_shop_path
  end

  private

  def find_cart
    shop = Shop.find(params[:shop_id])
    cart = shop.carts.find_by(id: session[:cart_ids].to_a)

    if !cart
      cart = shop.carts.create
      session[:cart_ids] = Set.new if session[:cart_ids].nil?
      session[:cart_ids] << cart.id
    end
    session[:current_shop_id] = shop.id
    cart
  end

end
