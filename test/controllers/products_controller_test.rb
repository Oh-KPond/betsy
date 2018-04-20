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

  describe "new" do
    it "succeeds" do
      get product_path(products(:cat))
      must_respond_with :success
    end
  end

  describe "create" do
    # it "creates a product with valid data" do
    #   proc {
    #     post products_path, params: {
    #       product: {
    #         name: "Bunny",
    #         stock: 14,
    #         price: 5,
    #         description: "Too many, please help",
    #         status: true,
    #         user_id: users(:ada).id,
    #         image_url: "test URL"
    #       }
    #     }
    #   }.must_change "Product.count", 1
    #
    #   must_respond_with :redirect
    #   must_redirect_to products_path
    # end

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



    it "should get edit" do
      get edit_product_path(products(:cat))
      must_respond_with :success
    end
end
