class ProductsController < ApplicationController

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)

    if @product.save
      # flash[:status] = :success
      # flash[:result_text] = "Successfully created #{@product.name}"
      redirect_to products_path
    else
      # flash[:status] = :failure
      # flash[:result_text] = "Could not create #{@product.name}"
      # flash[:messages] = @product.errors.messages
      render :new, status: :bad_request
    end
  end

  def index
    @categories= Category.all
    @products = Product.all
    find_order
    @orders_products = @order.order_items.new
  end

  def show
    @product = Product.find_by(id: params[:id])

    if @product.nil?
      redirect_to products_path
    end

    if @user
      @order = Order.find(session[:user_open_order_id])
    else
      @order = session[:guest_order]
    end

    @order_item = OrderItem.new(product_id: @product.id)
  end

  def edit
    @product = Product.find_by(id: params[:id])
  end

  def update
    @product = Product.find_by(id: params[:id])
    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit
    end
  end


  private
  def product_params
    params.require(:product).permit(:name, :stock, :price, :description, :status, :user_id, :image_url, category_ids:[])
  end
end
