class ApplicationController < ActionController::Base
  around_action :set_locale

  def set_locale(&action)
    if params[:language] && I18n.available_locales.include?( params[:language].to_sym )
      session[:language] = params[:language]
    end

    I18n.with_locale(session[:language] || I18n.default_locale, &action)
  end

  helper_method :current_user, :user_loged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user])
  end

  def user_loged_in?
    # session[ENV["session_name"]]
    current_user.present?
  end
  
  def authenticate_admin
    unless current_user.admin?
      # flash[:alert] = '你沒有權限進入！'
      redirect_to root_path, notice: t('not_admin')
    end
  end

  # def admin?
  #   session[ENV["user_role"]] == "admin"
  # end

  def no_user_loged
    if current_user.nil?
      # session[ENV['session_name']] == nil
      redirect_to log_in_sessions_path, notice: t("log_before_start")
    end
  end

  def check_user_locked
    # @user = User.find_by!(id: session[ENV['session_name']])
    @user = current_user
    if @user.locked?
      redirect_to edit_users_path, notice: t("your account is locked")
    end
  end
end
