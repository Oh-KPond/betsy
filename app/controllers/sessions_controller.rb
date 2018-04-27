class SessionsController < ApplicationController


  def create
    auth_hash = request.env['omniauth.auth']

    if auth_hash['uid']
      @user = User.find_by(uid: auth_hash[:uid], provider: params[:provider])

      if @user.nil?

        # make a new user with method from model
        @user = User.build_from_github(auth_hash)
        successful_save = @user.save
        if successful_save
          flash[:success] = "Logged in successfully"
          redirect_to user_path(user.id)
        else
          flash[:error] = "Some error happened in user creation"
          redirect_to root_path
        end
      else
        flash[:success] = "Logged in successfully #{@user.username}"
        redirect_to root_path
      end

      session[:user_id] = @user.id
      new_order = Order.new(status: "pending")
      new_order.save
      session[:user_open_order_id]  = new_order.id

    else
      flash[:error] = "Logging in through GitHub not successful"
      redirect_to root_path
    end
  end


  def destroy
    session[:user_id] = nil

    flash[:success] = "Successfully logged out!"
    redirect_back(fallback_location: root_path)

  end
end
