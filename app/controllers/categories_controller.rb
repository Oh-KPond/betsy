class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    raise

    if @category.save
      flash[:success] = "Category created"
      redirect_to new_product_path
    else
      flash[:error] = "Category could not be created"
      redirect_back(fallback_location: new_product_path)
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
