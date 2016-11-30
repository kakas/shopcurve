class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    if subdomain.present?
      @user = User.from_omniauth(request.env["omniauth.auth"])

      if @user.persisted?
        register_current_user_as_member
        sign_in @user, :event => :authentication
        associate_order_to_current_user
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      else
        redirect_to root_url
      end
    else
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  private

  def subdomain
    request.subdomain
  end

  def register_current_user_as_member
    @shop = Shop.find_by(subdomain: subdomain)
    if @shop && !@shop.members.include?(@user)
      @shop.members << @user
    end
  end

  def associate_order_to_current_user
    if session[:order_token]
      order = Order.find_by(token: session[:order_token])
      session.delete(:order_token)
      @user.orders << order if order

      redirect_to order_url(order.token)
    else
      redirect_to root_url
    end
  end

end
