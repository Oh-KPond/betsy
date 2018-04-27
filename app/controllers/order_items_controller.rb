class OrderItemsController < ApplicationController

  def create
    find_order
    p_id = params[:order_item][:product_id]

    if @order.order_items.where(product_id: p_id).length != 0
      flash[:error] = "Product already exists in cart"
      redirect_to new_order_path
    else
      @order_item = @order.order_items.new(order_item_params)
      @order_item.order_id = @order.id

      if @order_item.save
        flash[:success] = "Added to cart"
        redirect_to new_order_path
      else
        flash[:error] = "Product not added to cart"
        redirect_back(fallback_location: new_order_path)
      end
    end
  end

  def update
    @order = find_order
    order_item = OrderItem.find(params[:id])
    new_quantity = params[:quantity][:quantity]

    if order_item.update(quantity: new_quantity)
      flash[:success] = "Quantity updated"
      redirect_to new_order_path
    else
      flash[:error] = "Quantity could not be updated"
      redirect_back(fallback_location: new_order_path)
    end
  end

  def destroy
    order_item = OrderItem.find(params[:id])
    if order_item.destroy
      flash[:success] = "Product removed from cart"
      redirect_back(fallback_location: new_order_path)
    else
      flash[:error] = "Product was not removed from cart"
      redirect_back(fallback_location: new_order_path)
    end
  end


  def change_status
  @order_item = OrderItem.find_by(id: params[:id])
  unless @order_item
    render_404
    return
  end

  @merchant = Merchant.find_by(id: @order_item.product.merchant_id)
  unless @merchant
    render_404
    return
  end

  if @merchant.id != @auth_user.id
    flash[:status] = :failure
    flash[:message] = "You can only make changes to your own products"
    return redirect_to merchant_path(@auth_user)
  end

  change = @order_item.change_status(params[:status])

  case change
  when nil
    flash[:status] = :success
    flash[:message] = "No changes made"
  when true
    flash[:status] = :success
    flash[:message] = "Status successfully changed to #{@order_item.status}"
  when false
    flash[:status] = :failure
    flash[:message] = "Unable to change status"
    flash[:details] = @order_item.errors.messages
  end
  redirect_to merchant_path(@merchant)
end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id, :order_id)
  end

end
