class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    end
  end

  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

  def edit
    @product = Product.find_by(id: params[:id])
  end

  def update
  end

  def destroy #remove from actively available
    @product = Product.find_by(id: params[:id])
    if @product
      @product.status = false
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :stock, :price, :description, :status, :user_id, :image_url)
  end
end
