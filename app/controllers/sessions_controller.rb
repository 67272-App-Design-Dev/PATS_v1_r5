#  Our session controller is just like the HomeController, 
# it does not have a table in the database associated with it.
# It is just a controller that helps us manage the stuff and keep track of the session. 

class SessionsController < ApplicationController
  def new
    # rendering the view with the a blank login form
  end
  
  # logging in by adding the user_id in the session hash 
  # after making sure the username
  #  and password are correct.
  def create
    user = User.authenticate(params[:username], params[:password])
    if user#.not_nil
      session[:user_id] = user.id
      redirect_to home_path, notice: "Logged in!"
    else
      flash.now.alert = "Username and/or password is invalid"
      render "new"
    end
  end
  
  # logging out: setting the user id to nil in the session hash
  def destroy
    session[:user_id] = nil
    redirect_to home_path, notice: "Logged out!"
  end
end