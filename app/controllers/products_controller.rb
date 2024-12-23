class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def index
    @products = Product.includes(:user)
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to products_path, success: "#{Product.model_name.human}が作成されました。"
    else
    flash.now[:danger] = "#{Product.model_name.human}の作成に失敗しました。"
    render :new, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :diagnosis, :product_number)
  end
end
