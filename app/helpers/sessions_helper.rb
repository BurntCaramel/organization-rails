module SessionsHelper
  include DashboardHelper

  def sign_in_user(user)
    session[:current_user] = user
  end

  def current_user
    session[:current_user]
  end

  def check_current_user
    @current_user = session[:current_user]
  end

  def require_current_user
    check_current_user
    redirect_to_dashboard if @current_user.nil?
  end

  def logged_in?
    current_user.present?
  end

  def current_user_identifier
    current_user['uid']
  end
end
