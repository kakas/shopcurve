class BuyerController < ApplicationController
  helper_method :current_shop, :current_cart, :subdomain
  before_action :shop_required!

  protected

  def current_cart
    if session[:current_shop_id] == params[:shop_id].to_i
      @current_cart ||= find_cart
    else
      @current_cart = find_cart
    end
  end

  def current_shop
    @shop ||= Shop.find_by(subdomain: subdomain)
  end

  def subdomain
    request.subdomain
  end

  private

  def shop_required!
    @shop = Shop.find_by(subdomain: subdomain)

    if @shop.nil?
      redirect_to root_url(subdomain: "")
    end
  end

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
