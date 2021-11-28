require 'coltrane'

class ChordsController < ApplicationController
  include Coltrane::Theory

  def find_by_notes
    @chord = nil
    @error = nil
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
