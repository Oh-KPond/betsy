class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)


    if @category.save
      flash[:success] = "Category created"
      redirect_to new_user_product_path(@user)
    else
      flash[:error] = "Category could not be created"
      redirect_back(fallback_location: new_user_product_path(@user))
    end
  end

  def show
    @category = Category.find_by(id: params[:id])
    @products = @category.products
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

end
