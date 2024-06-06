require 'test_helper'

class HeadquartersControllerTest < ActionDispatch::IntegrationTest
  test 'should get overview' do
    get root_url
    assert_response :success
  end

  test 'should get solutions' do
    get solutions_url
    assert_response :success
  end
end
