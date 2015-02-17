class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :ensure_signed_in
  helper_method :current_user

  private
    def current_user
      User.find_by(id: session[:user_id])
    end

    def ensure_signed_in
      unless current_user
        redirect_to signin_path, notice: 'Hey there, you need to sign in first.'
      end
    end
end
