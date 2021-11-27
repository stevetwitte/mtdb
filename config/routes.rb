Rails.application.routes.draw do
  root 'chords#search'

  get 'chords/search'
end
