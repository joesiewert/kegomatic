class RegistrationsController < ApplicationController
  skip_before_action :ensure_signed_in

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :password, :password_confirmation))
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @sign_up_errors = @user.errors.full_messages
      render :new
    end
  end
end
