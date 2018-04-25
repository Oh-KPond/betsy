class OrderItemsController < ApplicationController

  def create
    find_order
    @order_item = @order.order_items.new(order_item_params)
    @order_item.order_id = @order.id
    @order_item.save


    redirect_to new_order_path
  end

  def update
    @order = find_order
    order_item = OrderItem.find(params[:id])
    new_quantity = params[:quantity][:quantity]
    order_item.update(quantity: new_quantity)

    redirect_to new_order_path
  end
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
