require "rails_helper"

RSpec.describe OrganizationInvitationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/organization_invitations").to route_to("organization_invitations#index")
    end

    it "routes to #new" do
      expect(:get => "/organization_invitations/new").to route_to("organization_invitations#new")
    end

    it "routes to #show" do
      expect(:get => "/organization_invitations/1").to route_to("organization_invitations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/organization_invitations/1/edit").to route_to("organization_invitations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/organization_invitations").to route_to("organization_invitations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/organization_invitations/1").to route_to("organization_invitations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/organization_invitations/1").to route_to("organization_invitations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/organization_invitations/1").to route_to("organization_invitations#destroy", :id => "1")
    end

  end
end
