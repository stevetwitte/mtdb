Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  get 'home/index'
  get 'tools/index'
  get 'theory/index'

  resources :chords, only: [:index, :show] do
    collection do
      get 'find-by-notes', to: 'chords#find_by_notes'
      post 'search'
    end
  end

  resources :scales, only: [:index, :show] do
    collection do
      get 'find-by-root-note', to: 'scales#find_by_root_note'
      post 'search'
    end
  end

  resources :notes, only: [:index, :show]
end
