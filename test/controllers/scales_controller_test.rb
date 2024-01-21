require 'test_helper'
require 'coltrane'

class ScalesControllerTest < ActionDispatch::IntegrationTest
  include Coltrane::Theory

  test 'should get find-by-root-note' do
    get find_by_root_note_scales_url
    assert_response :success
  end

  test 'should get index' do
    get scales_url
    assert_response :success
    assert_equal 'SCALES / SCALES BY TYPE', assigns(:breadcrumbs)
  end

  test 'should get show' do
    get scale_url('Major')
    assert_response :success
    assert_equal 'SCALES / Major', assigns(:breadcrumbs)
    assert_not_nil assigns(:scales)
  end

  test 'should get search' do
    post search_scales_url, params: { query: 'C', scale_type: 'Major' }
    assert_response :success
    assert_not_nil assigns(:scale)
    assert_not_nil assigns(:note_names)
  end
end
