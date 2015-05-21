class ApplicationController < ActionController::Base
  before_action :authorize
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

    def authorize
      redirect_to login_url, notice: 'Please, log in.' unless session[:user_id] && User.find(session[:user_id])
    end

end
