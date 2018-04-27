require "test_helper"

describe CategoriesController do
  describe "index" do
    it "succeeds when there are categories" do
        Category.count.must_equal 3
        get categories_path
        must_respond_with :success
    end

    it "succeeds when there are no categories" do
      Category.all.each do |item|
        item.destroy
      end

      Category.count.must_equal 0
      get categories_path
      must_respond_with :success
    end
  end

  describe "new" do
    it "succeeds" do
      get new_category_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "creates a product with valid data" do
      Category.count.must_equal 3
      user = users(:ada)
      login(user)
      category_params = {
        name: "Dangerous"
      }

      Category.new(category_params).must_be :valid?

      post categories_path, params: {category: category_params}
      must_respond_with :redirect
      must_redirect_to user_path(user.id)
      Category.count.must_equal 4
    end


    it "does not create a product with invalid data" do
      Category.count.must_equal 3
      user = users(:ada)
      login(user)
      category_params = {
        name: ""
      }

      Category.new(category_params).must_be :valid?

      post categories_path, params: {category: category_params}
      must_respond_with :redirect
      must_redirect_to user_path(user.id)
      Category.count.must_equal 3
    end

  end

end
