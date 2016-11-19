require 'rails_helper'

RSpec.describe "organization_invitations/index", type: :view do
  before(:each) do
    assign(:organization_invitations, [
      OrganizationInvitation.create!(
        :organization => nil,
        :email => "Email"
      ),
      OrganizationInvitation.create!(
        :organization => nil,
        :email => "Email"
      )
    ])
  end

  it "renders a list of organization_invitations" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
