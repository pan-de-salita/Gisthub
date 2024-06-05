require "test_helper"

class HeadquartersControllerTest < ActionDispatch::IntegrationTest
  test "should get overview" do
    get headquarters_overview_url
    assert_response :success
  end

  test "should get repositories" do
    get headquarters_repositories_url
    assert_response :success
  end
end
