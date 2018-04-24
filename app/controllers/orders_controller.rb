class OrdersController < ApplicationController
  def index
  end

  def create
    if @user
      @order = Order.find(session[:user_open_order_id])
    else
      @order = Order.find(session[:guest_order_id])
    end

    @order.status = "paid"


    if @order.save
      flash[:success] = "Thank you for placing your order!"
      redirect_to root_path
    else
      # this makes the error messages into a flash hash so it can be used by application.html.erb
      flash.now[:alert] = @order.errors
      render :new
    end
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
