class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def authenticate_user
    if session[:user_id]
      @current_user = User.find session[:user_id]
      true
    else
      redirect_to(:controller => 'home', :action => 'index')
      false
    end
  end

  def save_login_state
    if session[:user_id]
      redirect_to(:controller => 'users', :action => 'profile')
      false
    else
      true
    end
  end

end
