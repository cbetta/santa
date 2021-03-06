class ApplicationController < ActionController::Base
  #keep this at the top at all times
  before_filter :load_user
  
  protect_from_forgery

  before_filter :require_login
  
  helper_method :current_user, :logged_in?
  
private
  
  def require_login
    session[:redirect] = request.url
    unless logged_in?
      flash.keep
      redirect_to login_path 
    end
  end
  
  def current_user
    @current_user
  end
  
  def logged_in?
    current_user.present?
  end
  
  def load_user
    if session[:user]
      @current_user = User.find(session[:user])
    end
  end
  
  def login(user, target)
    session[:user] = user.id
    if session[:redirect] && session[:redirect].starts_with?(root_url)
      redirect  = session[:redirect]
      session[:redirect] = nil
      redirect_to redirect, notice: "You are now logged in"
    else 
      redirect_to target,  notice: "You are now logged in"
    end
  end
  
  def logout(target=nil)
    session.delete(:user)
    target ||= root_url
    redirect_to(target, notice: "You are now logged out")
  end

end
