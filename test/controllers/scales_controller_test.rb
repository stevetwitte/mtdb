require 'test_helper'

class ScalesControllerTest < ActionDispatch::IntegrationTest
  test 'should get find-by-root-note' do
    get find_by_root_note_scales_url
    assert_response :success
  end
end
