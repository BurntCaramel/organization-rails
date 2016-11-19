module OrganizationsHelper
  include DashboardHelper
  include SessionsHelper

  def set_parent_organization
    return unless require_current_user

    organization_id = params.fetch(:organization_id)
    @user_organization_capability = UserOrganizationCapability.find_by(user_identifier: current_user_identifier, organization_id: organization_id)
    if @user_organization_capability.nil?
      @organization = Organization.find_by(id: organization_id, owner_identifier: current_user_identifier)
      if @organization.nil?
        redirect_to dashboard_url, alert: 'You are not a part of this organization.'
        return
      end

      # If current user is owner, add an admin capability
      @user_organization_capability = UserOrganizationCapability.create!(
        organization: @organization,
        user_identifier: current_user_identifier,
        capabilities: :admin
      )
    end

    @organization = @user_organization_capability.organization 
  end
end
