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



  describe "create" do
    it "creates an order with valid data" do
      new_order_hash = {
        status: "pending",
        name_on_card: "Ada Lovelace",
        cc_num: "1234",
        cvv: 123,
        email: "ada@adadevelopersacademy.org",
        street_address: "123 Pine Street",
        state: "WA",
        city: "Seattle",
        zip: 98104
      }

      proc   {
        post orders_path, params: { new_order: new_order_hash }
      }.must_change 'Order.where(status: "paid").count', 1

      order = Order.find_by(zip: 98104)

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "renders bad_request and does not update the DB for bogus data" do
      bad_order_hash = {
        status: "pending",
        name_on_card: nil,
        cc_num: "1234",
        cvv: 123,
        email: "ada@adadevelopersacademy.org",
        street_address: "123 Pine Street",
        state: "WA",
        city: "Seattle",
        zip: 98104
      }

      proc   {
        post orders_path, params: { order: bad_order_hash }
      }.must_change 'Order.where(status: "paid").count', 0

      must_respond_with :bad_request
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
