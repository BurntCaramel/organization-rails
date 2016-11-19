require 'rails_helper'

RSpec.describe "organization_invitations/edit", type: :view do
  before(:each) do
    @organization_invitation = assign(:organization_invitation, OrganizationInvitation.create!(
      :organization => nil,
      :email => "MyString"
    ))
  end

  it "renders the edit organization_invitation form" do
    render

    assert_select "form[action=?][method=?]", organization_invitation_path(@organization_invitation), "post" do

      assert_select "input#organization_invitation_organization_id[name=?]", "organization_invitation[organization_id]"

      assert_select "input#organization_invitation_email[name=?]", "organization_invitation[email]"
    end
  end
end
