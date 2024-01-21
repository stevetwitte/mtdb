require 'test_helper'
require 'coltrane'

class RootsControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get chord_root_url('dim', 'C')
    assert_response :success
  end

  test 'should assign chord quality' do
    get chord_root_url('dim', 'C')
    assert_response :success
    assert_instance_of Coltrane::Theory::ChordQuality, assigns(:chord_quality)
  end

  test 'should assign chord' do
    get chord_root_url('dim', 'C')
    assert_response :success
    assert_instance_of Coltrane::Theory::Chord, assigns(:chord)
  end

  test 'should assign breadcrumbs' do
    get chord_root_url('M', 'C')
    assert_response :success
    assert_equal 'CHORDS / CM', assigns(:breadcrumbs)
  end
end
