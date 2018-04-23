class OrdersController < ApplicationController
  def index
  end

  def create
  end

  def new
    if @user
      @order = Order.find(session[:user_open_order_id])
    else
      @order = Order.find(session[:guest_order_id])
    end
  end

  def edit
  end

  def show
    if @user
      @order = Order.find(session[:user_open_order_id])
    else
      @order = session[:guest_order]
    end
  end

  def update
  end

  def destroy
  end
end
