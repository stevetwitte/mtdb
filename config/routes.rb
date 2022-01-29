Rails.application.routes.draw do
  root 'home#index'

  get 'home/index'
  get 'tools/index'

  resources :chords, only: [] do
    collection do
      get 'find-by-notes', to: 'chords#find_by_notes'
      post 'search'
    end
  end

  resources :scales, only: [] do
    collection do
      get 'find-by-root-note', to: 'scales#find_by_root_note'
      post 'search'
    end
  end
end
