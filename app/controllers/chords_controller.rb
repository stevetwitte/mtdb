class ChordsController < ApplicationController
  include Coltrane::Theory

  def index
    @chords = nil
  end

  def search
    if params[:query].present?
      search_notes = params[:query].strip.split(' ')
      @chords = Chord.new(notes: search_notes)
    else
      @chords = []
    end

    render turbo_stream: turbo_stream.replace(
      'chords',
      partial: 'list',
      locals: {
        chords: @chords
      }
    )
  end
end
