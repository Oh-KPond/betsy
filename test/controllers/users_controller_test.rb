require "test_helper"

describe UsersController do
  describe "index" do

    it "should get index" do
      get users_path
      must_respond_with :success
    end

    it "succeeds with no users" do
      users(:ada).destroy
      users(:grace).destroy
      users(:gretchen).destroy

      users.count.must_equal 0

    end
  end

  describe "show" do
    it "should get show" do
      id = users(:ada).id
      get users_path(id)

      must_respond_with :success
    end
  end

  describe "update" do
    it "should change user information" do
      updated_username = "CandyCanes111"
      put user_path(users(:grace).id), params: { user: { username: updated_username}  }

      updated_user = User.find(users(:grace).id)
      updated_user.username.must_equal "CandyCanes111"
    end
  end

end
