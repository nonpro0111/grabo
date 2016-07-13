Admin::Engine.routes.draw do
  devise_for :users, class_name: "Admin::User", module: :devise, controllers: {sessions: "admin/sessions"}
  resources :home, only: :index

  root "home#index"

  resources :videos
end
