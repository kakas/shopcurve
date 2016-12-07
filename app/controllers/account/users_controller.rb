class Account::UsersController < BuyerController
  before_action :authenticate_user!

  def edit
  end

  def update
    if current_user.update(user_params)
      flash[:success] = "成功更新個人資料"
      redirect_to products_path
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :phone, :address, :email)
  end

end
