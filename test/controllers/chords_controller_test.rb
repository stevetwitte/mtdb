require 'test_helper'

class ChordsControllerTest < ActionDispatch::IntegrationTest
  test 'should get search' do
    get find_by_notes_chords_url
    assert_response :success
  end
end
