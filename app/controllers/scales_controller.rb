require 'coltrane'

class ScalesController < ApplicationController
  include Coltrane::Theory

  def find_by_root_note
    @scale_types = Scale.standard_scales
    @scale = nil
    @error = nil
  end

  def search
    if params[:query].present?
      root_note = params[:query].strip
      scale_type = params[:scale_type].strip
      @scale = Scale.fetch(scale_type, root_note)
    end

    render turbo_stream: turbo_stream.replace(
      'scale',
      partial: 'scale_summary',
      locals: {
        scale: @scale,
        error: nil
      }
    )
  rescue StandardError => e
    render turbo_stream: turbo_stream.replace(
      'scale',
      partial: 'scale_summary',
      locals: {
        scale: nil,
        error: e.message
      }
    )
  end
end
