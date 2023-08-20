Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, controllers: { confirmations: 'users/confirmations',
                                    passwords: 'users/passwords',
                                    registrations: 'users/registrations',
                                    sessions: 'users/sessions',
                                    unlocks: 'users/unlocks' }


  get 'home/index'
  get 'tools/index'
  get 'theory/index'

  resources :chords, only: [:index, :show] do
    resources :roots, only: [:show]

    collection do
      get 'find-by-notes', to: 'chords#find_by_notes'
      post 'search'
    end
  end

  resources :users, except: [:index]

  resources :scales, only: [:index, :show] do
    collection do
      get 'find-by-root-note', to: 'scales#find_by_root_note'
      post 'search'
    end
  end

  resources :notes, only: [:index, :show]
end
