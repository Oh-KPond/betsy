class Product < ApplicationRecord

  def self.status_change #change availability
    @product = Product.find_by(id: params[:id])
    if @product
      @product.status = false
    end
  end
end
