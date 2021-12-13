Rails.application.routes.draw do
  root 'chords#find_by_notes'

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
