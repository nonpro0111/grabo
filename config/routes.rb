Rails.application.routes.draw do
  resources :contacts, only: [:new, :create] do
    collection do
      get 'finish'
    end
  end

  root 'videos#index'

  resources :videos, only: [:index, :show] do
    collection do
      get 'search'
      get 'feed'
    end
  end

  resources :idols, only: [:index]

  mount Admin::Engine, at: :admin
end
