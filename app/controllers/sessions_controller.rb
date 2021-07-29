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
      redirect_to root_path
    else
      redirect_to log_in_sessions_path, notice: t("login_error")
    end
  end

  def destroy
    session[ENV["session_name"]] = nil
    redirect_to log_in_sessions_path, notice: t("log_out")
  end


  private 
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
