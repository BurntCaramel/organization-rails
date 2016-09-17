module OrganizationsHelper
  include DashboardHelper

  def set_parent_organization
    @organization = Organization.find_by(id: params[:organization_id], owner_identifier: current_user_identifier) 
    redirect_to(dashboard_url, alert: 'You are not a part of this organization.') if @organization.nil?
  end
end
