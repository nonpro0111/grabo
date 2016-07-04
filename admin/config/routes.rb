Admin::Engine.routes.draw do
  devise_for :users, class_name: "Admin::User", module: :devise
  resources :videos
  resources :home, only: :index

  root "home#index"
end
