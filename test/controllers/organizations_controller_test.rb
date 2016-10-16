require 'test_helper'

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  include DashboardHelper

  setup do
    @ateam = organizations(:ateam)
    @lanisters = organizations(:lanisters)
  end

  test "should redirect get index when logged out" do
    get organizations_url
    assert_redirected_to dashboard_url
  end

  test "should redirect get new when logged out" do
    get new_organization_url
    assert_redirected_to dashboard_url
  end


  # test "should create organization" do
  #   assert_difference('Organization.count') do
  #     post organizations_url, params: { organization: { name: @ateam.name, owner_identifier: @ateam.owner_identifier } }
  #   end

  #   assert_redirected_to organization_url(Organization.last)
  # end

  # test "should show organization" do
  #   get organization_url(@ateam)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_organization_url(@ateam)
  #   assert_response :success
  # end

  # test "should update organization" do
  #   patch organization_url(@ateam), params: { organization: { name: @ateam.name, owner_identifier: @ateam.owner_identifier } }
  #   assert_redirected_to organization_url(@ateam)
  # end

  # test "should destroy organization" do
  #   assert_difference('Organization.count', -1) do
  #     delete organization_url(@ateam)
  #   end

  #   assert_redirected_to organizations_url
  # end
end
