# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_Tuia_session_id'

  def login_required
    if session[:user]
      return true
    end
    flash[:warning] = 'Por favor, efetue o login para continuar...'
    session[:return_to] = request.request_uri
    redirect_to :controller => "user", :action => "login"
    return false 
  end

  def is_admin
    unless current_user.admin
      flash[:warning] = 'Você não tem permissão para executar este comando...'
      redirect_to :controller => 'user', :action => 'welcome'
    end
    return true
  end

  def numberOfPages
    50
  end

  def set_charset
    headers["Content-Type"] = "text/html; charset=ISO-8859-1" 
  end

  def current_user
    session[:user]
  end

  def redirect_to_stored
    if (return_to = session[:return_to])
      session[:return_to] = nil
      redirect_to(return_to)
    else
      redirect_to :controller => 'user', :action => 'welcome'
    end
  end
end
