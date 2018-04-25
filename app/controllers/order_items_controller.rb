class OrderItemsController < ApplicationController

  def create
    if @user
      @order = Order.find(session[:user_open_order_id])
    else

      @order = Order.find(session[:guest_order_id])
    end
    @order_item = @order.order_items.new(order_item_params)
    @order_item.order_id = @order.id
    @order_item.save

<<<<<<< HEAD
    flash[:status] = :success
          flash[:result_text] = "Successfully added to cart"
=======


>>>>>>> a5261b3d2336b563803dfc0ccd41d028a7e4df32
    redirect_to new_order_path
  end

  # def update
  #   @order = current_order
  #   @order_item = @order.order_items.find(params[:id])
  #   @order_item.update_attributes(order_item_params)
  #   @order_items = @order.order_items
  # end
  #
  # def destroy
  #   @order = current_order
  #   @order_item = @order.order_items.find(params[:id])
  #   @order_item.destroy
  #   @order_items = @order.order_items
  # end
  private
    def order_item_params
      params.require(:order_item).permit(:quantity, :product_id, :order_id)
    end
end
