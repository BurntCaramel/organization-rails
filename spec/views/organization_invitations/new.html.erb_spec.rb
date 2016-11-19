require 'rails_helper'

RSpec.describe "organization_invitations/new", type: :view do
  before(:each) do
    assign(:organization_invitation, OrganizationInvitation.new(
      :organization => nil,
      :email => "MyString"
    ))
  end

  it "renders new organization_invitation form" do
    render

    assert_select "form[action=?][method=?]", organization_invitations_path, "post" do

      assert_select "input#organization_invitation_organization_id[name=?]", "organization_invitation[organization_id]"

      assert_select "input#organization_invitation_email[name=?]", "organization_invitation[email]"
    end
  end
end
