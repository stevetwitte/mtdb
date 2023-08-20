require 'coltrane'

class RootsController < ApplicationController
  include Coltrane::Theory

  def show
    @chord_quality = ChordQuality.new(name: CGI.unescape(params[:chord_id]))
    @chord = Chord.new(root_note: Note[params[:id].upcase.gsub('_SHARP', '#').gsub('_FLAT', 'b')],
                       quality: @chord_quality)
    @breadcrumbs = "CHORDS / #{@chord.name}"
  end
end
