class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def render_404
    respond_to do |format|
      format.html{
        render :file => "public/404.html", :status => 404, :layout=>false
      }
    end
    true
  end
  
  def render_403
    respond_to do |format|
      format.html{render :file => "public/403.html", :status => 403, :layout=>false }
    end
    true
  end
  
  def clear_flash
    flash[:notice] = ""
  end
  
  def require_user
    unless current_user
      store_location
      message = "You must be logged in to access this page"
      flash[:notice] = message
      respond_to do |format|
        format.html{ redirect_to new_user_session_url }
        format.js{
          render :update do |page|
            page << "sendAjaxRequest('#{new_user_session_url}');"
          end
        }
      end
      return false
    end
  end
  
  private

  def store_location
    session[:return_to] = request.fullpath
  end

  def clear_stored_location
    session[:return_to] = nil
  end
  
end
