class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    if subdomain.present?
      @user = User.from_omniauth(request.env["omniauth.auth"])

      if @user.persisted?
        register_current_user_as_member
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
    @shop.members << @user if @shop
  end

end
