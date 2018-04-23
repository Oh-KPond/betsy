class OrdersController < ApplicationController
  def index
  end

  def create

  end

  def new
    @user = User.find_by(id: session[:user_id])

    if @user == nil
      @order = Order.find_by(user_id: @cached_guest_user.id, status: "pending")
    else
      @order = Order.find_by(user_id: @user.id, status: "pending")
    end

  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

end
