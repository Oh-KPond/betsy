require "test_helper"
require "pry"

describe ProductsController do
  describe "index" do
    it "should get index" do
        Product.count.must_equal 3
        get products_path
        must_respond_with :success
    end

    it "succeeds when there are no works" do
        Product.all.each do |item|
          item.destroy
        end

        Product.count.must_equal 0
        get products_path
        must_respond_with :success
      end
  end

  describe "show" do
    it "succeeds" do
      get product_path(products(:cat))
      must_respond_with :success
    end

    it "redirects if not in db" do

    end
  end

  describe "new" do
    it "succeeds" do
      get new_product_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "creates a product with valid data" do
      Product.count.must_equal 3

      # login_user(users(:ada))
        post products_path params: {
          product: {
            name: "Bunny",
            stock: 14,
            price: 5,
            description: "Too many, please help",
            status: true,
            user_id: users(:ada).id,
            image_url: "www.test-URL.com"
          }
        }

      Product.count.must_equal 4
      # must_respond_with :redirect
      # must_redirect_to products_path
    end

  #   it "renders bad_request and does not update the DB for bogus data" do
  #     proc {
  #       post works_path, params: {
  #         work: {
  #           title: "",
  #           creator: "An author",
  #           category: "Book",
  #           publication_year: 1984
  #         }
  #       }
  #     }.must_change "Work.count", 0
  #
  #     Work.count.must_equal 4
  #     must_respond_with :bad_request
  #   end
  end


  describe "edit" do
    it "succeeds for an extant product ID" do
      get edit_product_path(products(:cat).id)
      must_respond_with :success
    end

    # it "renders 404 not_found for a bogus work ID" do
    #   get edit_product_path("carrot")
    #   must_respond_with :not_found
    # end

  end

end
