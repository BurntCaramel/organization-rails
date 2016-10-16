require 'test_helper'

class RipplesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get ripples_create_url
    assert_response :success
  end

  test "should get destroy" do
    get ripples_destroy_url
    assert_response :success
  end

end
