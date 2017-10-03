class ApplicationController < ActionController::Base
 # Prevent CSRF attacks by raising an exception.
 # For APIs, you may want to use :null_session instead.
 protect_from_forgery with: :exception
 before_action :configure_permitted_parameters, if: :devise_controller?
 before_action :set_global_search_var

 def set_global_search_var
    @q = Pin.search(params[:q])
    #@pins = Pin.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 6)
    @pins = @q.result(:distinct => true).order("created_at DESC").page(params[:page]).per(6)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :username, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :username, :email, :password, :current_password, :bio) }
  end
end
