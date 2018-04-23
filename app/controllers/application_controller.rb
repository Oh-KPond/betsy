class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :find_session
  before_action :get_categories

  def get_categories
    @categories = Category.all
  end

  # if user is logged in, return current_user, else return guest_user
  def find_session
    find_user

    if @user == nil
      if session[:guest_order_id] == nil
        new_order = Order.new(status: "pending")
        new_order.save
        session[:guest_order_id] = new_order.id
      end

    else
      if Order.find_by(id: session[:user_open_order_id])
        @user
      else
        @order = Order.new(status: "pending")
        @order.save
        session[:user_open_order_id] = @order.id
      end

      @user
    end
  end

  def find_user
    @user = User.find_by(id: session[:user_id])
  end
end
