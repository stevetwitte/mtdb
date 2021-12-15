class HomeController < ApplicationController
  layout 'home'

  def index
    @breadcrumbs = 'HOME'
  end
end
