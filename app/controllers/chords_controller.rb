require 'coltrane'

class ChordsController < ApplicationController
  include Coltrane::Theory

  def index
    @breadcrumbs = 'CHORDS <strong>&gt;</strong> CHORDS BY TYPE'
    @chord_qualities = ChordQuality::NAMES.map { |n| n[0] }
  end

  def show
    @chord_quality = ChordQuality.new(name: CGI.unescape(params[:id]))
    @breadcrumbs = "CHORDS <strong>&gt;</strong> #{@chord_quality.name}"
    @chords = Note.all.map do |n|
      Chord.new(root_note: n, quality: @chord_quality)
    end
  end

  def find_by_notes
    @breadcrumbs = 'TOOLS <strong>&gt;</strong> CHORD FINDER'
  end

  def search
    if params[:query].present?
      search_notes = params[:query].strip.split(' ')
      @chord = Chord.new(notes: search_notes)
    end

    render turbo_stream: turbo_stream.replace(
      'chord',
      partial: 'chord_summary',
      locals: {
        chord: @chord,
        error: nil
      }
    )
  rescue StandardError => e
    render turbo_stream: turbo_stream.replace(
      'chord',
      partial: 'chord_summary',
      locals: {
        chord: nil,
        error: e.message
      }
    )
  end
end
