require 'test_helper'

class ToolsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get tools_index_url
    assert_equal 'TOOLS', assigns(:breadcrumbs)
    assert_response :success
  end
end
