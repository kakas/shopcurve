class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    if subdomain.present?
      @user = User.from_omniauth(request.env["omniauth.auth"])

      if @user.persisted?
        register_current_user_as_member
        associate_order_to_current_user
        sign_in_and_redirect @user, :event => :authentication
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
    order = Order.find_by(token: session[:order_token])
    session.delete(:order_token)
    @user.orders << order if order
  end

end
