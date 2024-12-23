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

  def edit
    @product = current_user.products.find(params[:id])
  end

  def destroy
    product = current_user.products.find(params[:id])
    product.destroy!
    redirect_to products_path, success: "#{Product.model_name.human}を削除しました。", status: :see_other
  end

  def update
    @product = current_user.products.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path(@product), success: "#{Product.model_name.human}を更新しました。"
    else
      flash.now[:danger] = "#{Product.model_name.human}の更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :diagnosis, :product_number)
  end
end
