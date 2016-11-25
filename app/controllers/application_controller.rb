class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def after_sign_in_path_for(resource)
    if request.subdomain.present?
      products_path
    else
      seller_shop_path
    end
  end

end
