class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :find_session

  def root
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
<<<<<<< HEAD
 end



 private

 # called (once) when the user logs in, insert any code your application needs
 # to hand off from guest_user to current_user.
 def logging_in

   ### Add anything we need to carry over from guest to logged in user
   ### (open order details)
   # For example:
   # guest_comments = guest_user.comments.all
   # guest_comments.each do |comment|
     # comment.user_id = current_user.id
     # comment.save!
   # end
 end

 def create_guest_user
   guest = User.new(:username => "guest", :email => "guest_#{Time.now.to_i}#{rand(100)}@example.com")
   guest.save!(:validate => false)
   session[:guest_user_id] = guest.id
   guest
 end


=======
  end
>>>>>>> 3c1b6be677d9609c4838a9df34d11ccc07fc176a
end
