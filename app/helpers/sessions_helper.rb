module SessionsHelper
  include DashboardHelper

  def sign_in_user(user)
    session[:current_user] = user
  end

  def current_user
    @current_user ||= session[:current_user]
  end

  def set_current_user
    current_user
  end

  def require_current_user
    if current_user.nil?
      redirect_to_dashboard
      false
    else
      true
    end
  end

  def logged_in?
    current_user.present?
  end

  def current_user_identifier
    current_user.fetch('uid')
  end
end
