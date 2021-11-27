require "test_helper"

class ChordsControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get chords_search_url
    assert_response :success
  end
end
