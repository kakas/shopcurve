class Seller::ProductsController < SellerController
  before_action :set_shop, only: [:index, :create, :edit, :update, :destroy]
  before_action :set_product, only: [:edit, :update, :destroy]
  layout "seller"

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @photo = @product.build_photo
  end

  def create
    @product = @shop.products.build(product_params)

    if @product.save
      redirect_to seller_products_path
    else
      @photo = @product.build_photo
      render :new
    end
  end

  def edit
    @photo = @product.photo || @product.build_photo
  end

  def update
    if @product.update(product_params)
      redirect_to seller_products_path
    else
      @photo = @product.photo || @product.build_photo
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to seller_products_path
  end

  private

  def set_shop
    @shop = Shop.first
  end

  def set_product
    @product = @shop.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, photo_attributes: [:image])
  end

end
