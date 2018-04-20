class Product < ApplicationRecord
  has_many :reviews
  has_and_belongs_to_many :categories
  belongs_to :users

  def self.status_change #change availability
    @product = Product.find_by(id: params[:id])
    if @product
      @product.status = false
    end
  end
end
