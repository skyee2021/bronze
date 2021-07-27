class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # byebug
    user = User.login(user_params)
    if user
      # session[:bronze]] = user.id
      session[ENV["session_name"]] = user.id
      session[ENV["user_role"]] = user.role
      session[ENV["user_email"]] = user.email
      
      redirect_to root_path
    else
      redirect_to log_in_sessions_path, notice: t("login_error")
    end
  end

  def destroy
    session[ENV["session_name"]] = nil
    session[ENV["user_role"]] = nil
    session[ENV["user_email"]] = nil
    session[ENV["user_name"]] = nil

    redirect_to log_in_sessions_path, notice: t("log_out")
  end


  private 
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
