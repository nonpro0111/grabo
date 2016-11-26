Rails.application.routes.draw do
  resources :contacts, only: [:new, :create] do
    collection do
      get 'finish'
    end
  end

  root 'videos#index'

  resources :videos, only: [:index, :show] do
    collection do
      get 'feed'
    end
  end

  resources :idols, only: [:index, :show] do
    collection do
      get 'search'
    end
  end

  mount Admin::Engine, at: :admin
end
