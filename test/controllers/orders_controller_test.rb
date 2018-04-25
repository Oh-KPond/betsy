require "test_helper"
require 'pry'

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


  describe "new" do
    it "succeeds" do
      get new_order_path
      must_respond_with :success
    end
  end



  describe "update" do
    it "updates an order with valid data" do
      order = orders(:open)

      order_info = {
      name_on_card: "Bunny",
      cc_num: "1234567",
      cvv: 121,
      email: "hello@hi.org",
      street_address: "111 Candy Cane Lane",
      state: "NP",
      city: "Santa",
      zip: 54321,
      status: "paid"
      }

      proc   {
        put order_path(order.id), params: { order: order_info }
      }.must_change 'Order.where(status: "paid").count', 1


      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "renders bad_request and does not update the DB for bogus data" do
      order = orders(:open)

      bad_order_hash = {
        status: "paid",
        name_on_card: nil,
        cc_num: "1234",
        cvv: 123,
        email: "apple@apple.apple",
        street_address: "123 Phinney",
        state: "KS",
        city: "Kansas",
        zip: 11111
      }

      proc   {
        put order_path(order.id), params: { order: bad_order_hash }
      }.must_change 'Order.where(status: "paid").count', 0

      must_respond_with :bad_request
    end

    it "reduces the quantity of each product on the order" do


    end
  end


  describe "show" do
    it "succeeds for an extant order ID" do
      order = orders(:one)

      get order_path(order.id)
      must_respond_with :success

    end

    it "renders 404 not_found for a bogus order ID" do
      get order_path("abc")
      must_respond_with :not_found
    end
  end

end
