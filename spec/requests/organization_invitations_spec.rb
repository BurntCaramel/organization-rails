require 'rails_helper'

RSpec.describe "OrganizationInvitations", type: :request do
  describe "GET /organization_invitations" do
    it "works! (now write some real specs)" do
      get organization_invitations_path
      expect(response).to have_http_status(200)
    end
  end
end
