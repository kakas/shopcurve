class Seller::ProductsController < SellerController
  before_action :shop_required!
  before_action :set_product, only: [:edit, :update, :destroy]
  layout "seller"

  add_breadcrumb "Products", :seller_products_path

  def index
    @products = current_shop.products.page params[:page]
  end

  def new
    @product = Product.new
    @photo = @product.build_photo
    add_breadcrumb "New Product", new_seller_product_path
  end

  def create
    @product = current_shop.products.build(product_params)

    if @product.save
      flash[:success] = "產品建立成功"
      redirect_to seller_products_path
    else
      @photo = @product.build_photo
      render :new
    end
  end

  def edit
    @photo = @product.photo || @product.build_photo
    add_breadcrumb "Edit Product", edit_seller_product_path(@product)
  end

  def update
    if @product.update(product_params)
      flash[:success] = "產品更新成功"
      redirect_to seller_products_path
    else
      @photo = @product.photo || @product.build_photo
      render :edit
    end
  end

  def destroy
    @product.destroy
    flash[:warning] = "#{@product.name}已被刪除"
    redirect_to seller_products_path
  end

  private

  def shop_required!
    if current_shop.blank?
      redirect_to seller_shop_path
    end
  end

  def set_product
    @product = current_shop.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :video, photo_attributes: [:image])
  end

end
