require 'rails_helper'

RSpec.describe "organization_invitations/show", type: :view do
  before(:each) do
    @organization_invitation = assign(:organization_invitation, OrganizationInvitation.create!(
      :organization => nil,
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Email/)
  end
end
