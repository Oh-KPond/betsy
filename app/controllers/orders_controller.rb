class OrdersController < ApplicationController
  def index
  end

  def create
  end

  def new
    if @user
      @order = @user.orders.find_by(status: "pending")
    else
      @order = @cached_guest_user.orders.find_by(status: "pending")
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
