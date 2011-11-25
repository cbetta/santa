class ApplicationController < ActionController::Base
  protect_from_forgery
  #keep this at the top
  before_filter :load_user
  
  before_filter :require_login
  
  helper_method :current_user, :logged_in?
  
private
  
  def require_login
    session[:redirect] = request.url
    redirect_to new_user_path unless logged_in?
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
      redirect_to redirect
    else 
      redirect_to target
    end
  end
  
  def logout(target=nil)
    session.delete(:user)
    redirect_to(target || root_url)
  end

end
