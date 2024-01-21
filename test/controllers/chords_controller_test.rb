# Frozen_string_literal: true

require 'test_helper'
require 'coltrane'

class ChordsControllerTest < ActionDispatch::IntegrationTest
  test 'should get search' do
    get find_by_notes_chords_url
    assert_response :success
  end

  test 'should get index' do
    get chords_url
    assert_response :success
    assert_select 'h1', 'CHORDS / CHORDS BY TYPE'
    assert_not_nil assigns(:chord_qualities)
  end

  test 'should get show' do
    chord_quality = Coltrane::Theory::ChordQuality::NAMES.first[0]
    get chord_url(chord_quality)
    assert_response :success
    assert_select 'h1', "CHORDS / #{chord_quality}"
    assert_not_nil assigns(:chord_quality)
    assert_not_nil assigns(:chords)
  end

  test 'should get find_by_notes' do
    get find_by_notes_chords_url
    assert_response :success
    assert_select 'h1', 'TOOLS / CHORD FINDER'
  end

  test 'should post search with valid query' do
    post search_chords_url, params: { query: 'C E G' }
    assert_response :success
    assert_select 'div#chord'
    assert_not_nil assigns(:chord)
    assert_nil assigns(:error)
  end

  test 'should post search with invalid query' do
    post search_chords_url, params: { query: 'invalid query' }
    assert_response :success
    assert_select 'div#chord'
    assert_select 'h2', 'ERROR:'
    assert_nil assigns(:chord)
  end
end
