class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  private
  # Handling authentication

  # Being "Logged in" or "Logged out" doesn't do us any good unless the application dynamically changes based on that state.
  # Here's how to make our application show which user is logged in and give options to sign up, log in, or sign out 
  # depending on state (logged in or out).
  # Let's start by making a current_user helper that we can call from any controller or view.
  # It will let us check if there is a current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    # TIP: The ||= part ensures this helper doesn't hit the database every time a user hits a web page.
    #  It will look it up once, then cache it in the @current_user variable.
    # It it checks first if a current_user is already fetched (not nil) and fetches it from the User table only if it is nil.

    #  We go to the session hash, If in fact the user_id is in the session hash, 
    # then go ahead and define the current user by that id.
  end
  # Make the current_user method available to views also, not just controllers, by defining a helper method:
  helper_method :current_user

  # We can pull out the current_user's name later like this:
  # current_user.first_name
  # Which will give us the name of the user who is currently logged in.
  # We can do that with any field on that user's record in the user table (username, phone, etc)
  
  #  We will also need to check if the user is still logged_in? 
  # This is done just by finding a current_user.
  def logged_in?
    current_user
  end
  # Make the logged_in? method available to views also, not just controllers, by defining a helper method:
  helper_method :logged_in?
  
  def check_login
    redirect_to login_path, alert: "You need to log in to view this page." if current_user.nil?
  end
end
