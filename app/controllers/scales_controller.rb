require 'coltrane'

class ScalesController < ApplicationController
  include Coltrane::Theory

  def find_by_root_note
    @breadcrumbs = 'TOOLS <strong>&gt;</strong> SCALE VIEWER'
    @scale_types = Scale.standard_scales
  end

  def search
    @scale_types = Scale.standard_scales

    if params[:query].present?
      @root_note = params[:query].strip
      @scale_type = params[:scale_type].strip
      @scale = Scale.fetch(@scale_type, @root_note)

      # TODO: This should be moved to colrane wrapper
      # it could also just be handled in the piano component
      @note_names = @scale.notes.map do |n|
        case n.name
        when 'E#'
          'F'
        when 'B#'
          'C'
        when 'A##'
          'B'
        when 'B##'
          'C#'
        when 'C##'
          'D'
        when 'D##'
          'E'
        when 'E##'
          'F#'
        when 'F##'
          'G'
        when 'G##'
          'A'
        else
          n.name
        end
      end
    end

    render turbo_stream: turbo_stream.replace(
      'scale',
      partial: 'scale_summary',
      locals: {
        scale: @scale,
        note_names: @note_names,
        scale_types: @scale_types,
        root_note: @root_note,
        scale_type: @scale_type,
        error: nil
      }
    )
  rescue StandardError => e
    render turbo_stream: turbo_stream.replace(
      'scale',
      partial: 'scale_summary',
      locals: {
        scale: nil,
        note_names: nil,
        scale_types: @scale_types,
        root_note: @root_note,
        scale_type: @scale_type,
        error: e.message
      }
    )
  end
end
