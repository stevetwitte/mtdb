Rails.application.routes.draw do
  root 'chords#index'

  resources :chords, only: [:index] do
    collection do
      post 'search'
    end
  end
end
