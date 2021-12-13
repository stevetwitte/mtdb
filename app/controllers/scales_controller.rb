require 'coltrane'

class ScalesController < ApplicationController
  include Coltrane::Theory

  def find_by_root_note
    @scale_types = Scale.standard_scales
    @scale = nil
    @error = nil
  end

  def search
    @scale_types = Scale.standard_scales

    if params[:query].present?
      @root_note = params[:query].strip
      @scale_type = params[:scale_type].strip
      @scale = Scale.fetch(@scale_type, @root_note)
    end

    render turbo_stream: turbo_stream.replace(
      'scale',
      partial: 'scale_summary',
      locals: {
        scale: @scale,
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
        scale_types: @scale_types,
        root_note: @root_note,
        scale_type: @scale_type,
        error: e.message
      }
    )
  end
end
