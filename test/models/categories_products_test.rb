require "test_helper"

describe CategoriesProducts do
  let(:categories_products) { CategoriesProducts.new }

  it "must be valid" do
    value(categories_products).must_be :valid?
  end
end
