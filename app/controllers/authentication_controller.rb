class AuthenticationController < ApplicationController
  def create
    user = User.find_by(username: params[:username].downcase.strip)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to elections_path
    else
      @sign_in_error = "Username/password combination is invalid"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
