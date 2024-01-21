require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get home_index_url
    assert_response :success
  end

  test 'should assign breadcrumbs' do
    get home_index_url
    assert_response :success
    assert_equal 'HOME', assigns(:breadcrumbs)
  end
end
