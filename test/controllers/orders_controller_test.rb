require "test_helper"

describe OrdersController do
  describe "index" do
    it "should get index" do

      get orders_path
      must_respond_with :success
    end

    it "succeeds with no orders" do

      orders = Order.all
      orders.destroy_all

      get orders_path

      must_respond_with :success
    end
  end
end
