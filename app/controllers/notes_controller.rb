require 'coltrane'

class ChordsController < ApplicationController
  include Coltrane::Theory

  before_action :set_notes, only: :index

  def index
    @breadcrumbs = 'NOTES / NOTES BY NAME'
  end

  private

  def set_notes
    @notes = Scale.standard_scales
  end
end
