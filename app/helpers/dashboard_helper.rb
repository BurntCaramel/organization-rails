module DashboardHelper
  def dashboard_path
    root_path
  end

  def dashboard_url
    root_url
  end

  def redirect_to_dashboard
    redirect_to dashboard_url
  end
end
