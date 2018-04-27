require "test_helper"
require 'pry'
describe SessionsController do

  it "logs in an existing user and redirect to root_path" do
    user = users(:ada)
    start_count = User.count
    login(user, :github)
    User.count.must_equal start_count
    must_redirect_to root_path
    session[:user_id].must_equal user.id
  end

  it "must have a username" do
    user = users(:ada)
    login(user, :github)
    user.username.must_equal "countess_ada"
  end

  it "logs in a new user" do
    user = User.create(provider: "github", uid: 12345, username: "cool", email: "cool@gmail.com")

    login(user, :github)
    
    session[:user_id].wont_be_nil

    must_redirect_to user_path(user.id)
  end

  it "clears the session and redirects back to the root path when a merchant logs out" do
    user = users(:ada)
    login(user, :github)
    delete logout_path
    session[:user_id].must_equal nil
    must_redirect_to root_path
  end

  it "notifies the user after it logs out" do
    user = users(:ada)
    logout(user, :github)
    delete logout_path
    flash[:status].must_equal :success
    flash[:result_text].must_equal "You successfully logged out."
  end

end
