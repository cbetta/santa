class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]
  before_filter :redirect_if_logged_in, :only => [:new, :create]

  ### shows the login page ###
  def new
  end

  ### logs a user in or creates a new user and then logs them in ###
  def create
    auth = request.env["omniauth.auth"]
    user = User.authenticate_or_create_with(auth)
    
    login(user, root_url)
  end
  
  ### logs out a user ###
  def destroy
    logout
  end

private
  
  def redirect_if_logged_in
    redirect_to root_url if logged_in?
  end

end
