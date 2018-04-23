class OrderItemsController < ApplicationController

  def create
    if @user
      @order = Order.find_by(user_id: @user.id, status: "pending")
    else
      @order = Order.find_by(user_id: @cached_guest_user.id, status: "pending")
    end
    @order_item = @order.order_items.new(order_item_params)
    @order_item.save


    redirect_back(fallback_location: root_path)
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
      params.require(:order_item).permit(:quantity, :product_id)
    end
end
