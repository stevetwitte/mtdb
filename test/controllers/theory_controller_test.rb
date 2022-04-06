require "test_helper"

class TheoryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get theory_index_url
    assert_response :success
  end
end
