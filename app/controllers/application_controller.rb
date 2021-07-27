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
    User.find_by(id: session[ENV["session_name"]])
  end

  def user_loged_in?
    session[ENV["session_name"]]
  end
  
  def authenticate_admin_or_org
    unless current_user.admin!
      flash[:alert] = '你沒有權限進入！'
      redirect_to root_path
    end
  end
end
