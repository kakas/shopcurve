class SellerController < ApplicationController
  before_action :authenticate_user!
  helper_method :current_shop

  protected

  def current_shop
    @current_shop ||= current_user.shop
  end
end
